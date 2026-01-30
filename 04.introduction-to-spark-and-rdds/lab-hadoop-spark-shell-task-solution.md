# Lab 1 Solution: Unstructured data analysis with RDDs
## Tasks:

1. Find the top 10 of the most used words in the whole book.

```python
word_count_top_10 = (
    words_no_empty
    .map(lambda words: ((words[1].lower()), words[2]))
    .reduceByKey(lambda c1, c2: c1 + c2)
    .map(lambda words: (words[1], words[0]))
    .sortByKey(ascending=False)
)
word_count_top_10.take(10)
```

## Advanced tasks:
1. Count number of words in each chapter.
2. Find the top 10 of the most used words by chapter.

### preparation

First, review the original context to identify useful patterns for data cleansing in each chapter.

And then we could easily notice that before each chapter, there's the following HTML pattern:

```html
<!--  H2 anchor --> </a>\r\n    </p>\r\n    <div style="height: 4em;">\r\n      <br /><br /><br /><br />\r\n    </div>\r\n    <h2>\r\n       CHAPTER 1
```

Next, we could observe that each chapter title will ends with:

```html
\r\n
```

These 2 features could be utilized in the following data cleansing section.

### split chapters

We will then generate key-value pairs for the chapter, where the key will be the chapter title and the value will be the corresponding content (chapter title, chapter content).

First, let's define a function to perform the spliting task. In our case, we will use a Python Regex library named `re`.

```python
import re

def extract_chapter(text):
    chapter_marker = '<!--  H2 anchor --> </a>\r\n    </p>\r\n    <div style="height: 4em;">\r\n      <br /><br /><br /><br />\r\n    </div>\r\n    <h2>\r\n      '
    end_marker = 'END OF THE PROJECT GUTENBERG'
    chapter_tuples = []
    chapters = text.split(chapter_marker)
    chapters = re.split(f"{chapter_marker}|{end_marker}", text)

    for chapter in chapters[1:-1]:
        period_index = chapter.find('\r\n')

        if period_index != -1:
            chapter_name = chapter[:period_index].strip()
            chapter_content = chapter[period_index+1:].strip()
            chapter_tuples.append((chapter_name, chapter_content))

    return chapter_tuples
```

In the function above, we first split each string by the keyword "CHAPTER". Next we identify the index of the first html characters ('\r\n') which appears immediately after the chapter title. Using this index, we extract both the chapter title and the chapter content. Finally, we append the extracted content as a tuple to the newly defined tuple.

```python
chapter = moby_dick.map(lambda content: content[1]).flatMap(extract_chapter)

chapter.collect()

chapter.count()
```

Remember the RDD `moby_dick` contains a tuple of 2 strings (the file location and the content of the book Moby-Dick), and we only need the second one. Until now, the data has now been split into a list of tuples, with each tuple containing 2 strings: a chapter title and chapter content. Including "Epilogue", there should be a total of 136 tuples. Check if you have the correct number.

### data cleansing

We clean the data by splitting the content based on various patterns such as: HTML tags, puntuation, and special characters.

```python
chapter_content = (chapter
    .map(lambda file_text: (
        file_text[0],
        re.split(r'''\r\n|<blockquote>|</blockquote>|&lsquo;|&ldquo;|&rdquo;|&amp;|<h2>|</h2>|<h3>|</h3>|<p>|</p>|<i>|</i>|<div\s+style=\'[^']*'>|</div>|<br />|</body>|</html>|<a href=".*">|</a>|<pre xml:space="preserve">|</pre>|\*|\s{6}<a name="link2H\w{4,6}" id="link2H\w{4,6}">|<span style='font-size:smaller'>|</span>|&mdash;|&#8212;|&#8482;| |:|\.|;|,|!|\?''', file_text[1])
        ))
)

chapter_content.take(1)
```
> note
- `&mdash;`: dash
- `&#8482;`: small TM mark
- `&#8212;`: em dash

The `&rsquo;` is excluded for the moment because it does not consistently represent direct speech. Instead, it often serves as an abbreviation within sentences.

### clean chapter title

We will then clean up the chapter titles by replacing the HTML codes with their corresponding symbols.

First, we define a replace function.
```python
def replace_html_code(text):
    replace_dict = {"&mdash;": "—", "&rsquo;": "'"}
    for char in replace_dict.keys():
        text = re.sub(char, replace_dict[char], text)
    return text
```

And implement the cleaning function to the chapter title.

```python
chapter_title_content = (chapter_content
    .map(lambda file_text: (
        replace_html_code(file_text[0]),
        file_text[1])
        ))

chapter_title_content.collect()
```

The task involves mapping the chapter title to the corresponding words in the text, while ensuring that empty values are removed. Additionally, we convert all words to lowercase for consistency.

```python
chapter_word_map = (chapter_title_content
    .map(lambda file_text: (
        file_text[0],
        [word.lower() for word in file_text[1] if word]))
    .flatMapValues(lambda x: x)
)

chapter_word_map.count()
```

### Advanced tasks 1: Count number of words in each chapter.

Using `countByKey()` to count the number of words based on its key: chapter title. The result will be a dictionary. Try to print it as human readable format.

```python
chapter_word_map.countByKey()

for chap, count in chapter_word_map.countByKey().items():
    print('{}: {} words'.format(chap, count))
```

### Advanced tasks 2: Find the top 10 of the most used words by chapter.

First, try to count the occurence of each word.

```python
from operator import add

word_count_rdd = (chapter_word_map
    .map(lambda x: ((x[0], x[1]), 1))
    .reduceByKey(add)
)

word_count_rdd.sortByKey().take(100)
```

A human readable version:

```python
for result in word_count_rdd.sortByKey().take(100):
    print(f"{result[1]} occurences for word: '{result[0][1]}' in '{result[0][0]}'")
```

Second, get the result by first defining a function to sort the most frequently used words in each chapter.

```python
def top_n_words(word_count, n=10):
    sorted_words = sorted(word_count, key=lambda x: x[1], reverse=True)
    return sorted_words[:n]
```

```python
word_count_chap_rdd = (word_count_rdd
    .map(lambda x: (x[0][0], (x[0][1], x[1]))).groupByKey())

top_words_by_chapter_rdd = word_count_chap_rdd.mapValues(lambda words: top_n_words(list(words)))

for chapter, top_word in top_words_by_chapter_rdd.collect():
    print(f"{chapter}: {top_word}")
```

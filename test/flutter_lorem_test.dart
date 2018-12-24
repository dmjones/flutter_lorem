// Copyright 2018 Duncan Jones
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

void main() {
  test('bad arguments handled', () {
    expect(() => lorem(paragraphs: -1), throwsA(isInstanceOf<ArgumentError>()));
    expect(
        () => lorem(paragraphs: null), throwsA(isInstanceOf<ArgumentError>()));
    expect(() => lorem(words: -1), throwsA(isInstanceOf<ArgumentError>()));
    expect(() => lorem(words: null), throwsA(isInstanceOf<ArgumentError>()));
  });

  test('test word count is correct', () {
    const words = 42;
    expect(_countWords(lorem(paragraphs: 1, words: words)), words);
  });

  test('test paragraph and word count is correct', () {
    const words = 200;
    const paragraphs = 13;

    final result = lorem(words: words, paragraphs: paragraphs);

    expect(_countParagraphs(result), paragraphs);
    expect(_countWords(result), words);
  });

  test('empty words', () {
    expect(lorem(paragraphs: 0), "");
    expect(lorem(words: 0), "");
  });

  test('paragraphs greater than words is ignored', () {
    const words = 3;
    final result = lorem(paragraphs: words * 2, words: words);
    expect(_countParagraphs(result), words);
    expect(_countWords(result), words);
  });
}

int _countParagraphs(final String input) => input.split("\n\n").length;
int _countWords(final String input) =>
    input.replaceAll("\n\n", " ").split(" ").length;

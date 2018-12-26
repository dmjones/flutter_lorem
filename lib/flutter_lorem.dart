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

import 'dart:math';
import 'package:flutter_lorem/src/words.dart';

Random _random = Random();

/// Generates random text using latin words. Words are distributed
/// evenly across the paragraphs.
String lorem({int paragraphs = 3, int words = 100}) {
  if (paragraphs == null || paragraphs < 0) {
    throw new ArgumentError.value(paragraphs, "paragraphs");
  }
  if (words == null || words < 0) {
    throw new ArgumentError.value(words, "words");
  }

  if (paragraphs == 0 || words == 0) {
    return "";
  }

  if (paragraphs > words) {
    // Not possible, so we downside to match words
    paragraphs = words;
  }

  return _makeParagraphs(paragraphs, words);
}

String _makeParagraphs(int paragraphs, int words) {
  int wordLength = words ~/ paragraphs;
  List<String> result = [];

  for (int i = 0; i < paragraphs - 1; i++) {
    result.add(_makeParagraph(wordLength));
  }

  // Last paragraph might need to be slightly larger
  result.add(_makeParagraph(wordLength + (words % paragraphs)));
  return result.join("\n\n");
}

String _makeParagraph(int words) {
  int remain = words;

  List<String> result = [];

  if (words == 1) {
    return _makeSentence(1);
  }

  while (remain > 0) {
    int length = _randomInRange(2, min(10, remain));

    // Avoid being left with tiny sentences.
    if (remain - length < 2) {
      length = remain;
    }

    result.add(_makeSentence(length));
    remain -= length;
  }

  return result.join(" ");
}

int _randomInRange(int minInclusive, int maxInclusive) {
  return _random.nextInt(maxInclusive - minInclusive + 1) + minInclusive;
}

String _makeSentence(int words) {
  List<String> result = [];
  int commas = 0;
  bool lastWasComma = false;

  for (int i = 0; i < words; i++) {
    String nextWord = _makeWord();

    // Add commas, occasionally (up to 2), but not consecutively
    if (lastWasComma) {
      lastWasComma = false;
    } else if (i != (words - 1) && commas < 2) {
      int n = _randomInRange(1, 7);
      if (n == 1) {
        nextWord += ",";
        commas++;
        lastWasComma = true;
      }
    }

    result.add(nextWord);
  }

  // Capitalise the first word in sentence
  result[0] = result[0].substring(0, 1).toUpperCase() + result[0].substring(1);

  return result.join(" ") + ".";
}

String _makeWord() {
  // 50% of words should be short
  int n = _random.nextInt(2);
  String chosen;

  do {
    chosen = wordList[_random.nextInt(wordList.length)];
  } while (n > 0 && chosen.length > 5);

  return chosen;
}

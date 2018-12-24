# flutter_lorem

A Flutter package for generating random sentences and paragraphs. The output looks similar to the famous "lorum ipsum"
placeholder text. Useful when designing user interfaces that require example text:

> Neo preclarus, mensa sono. Te laetabilis. Furor supremus mille procella sicut dolor construo illae addo vixi. 
> Ferre uti indagatio post.
>  
> Imitabilis singulus receptum facillimus quae, formo vel aliquis epulor ago. Aliud comprehendo, humus quam 
> expositus ops. Revoco donec, feteo fere.

## Usage

Import the package:

```dart
import 'package:flutter_lorem/flutter_lorem.dart';
```

Call the `lorum` function, specifying the number of paragraphs and words to generate.

```dart
String text = lorem(paragraphs: 2, words: 60);
print(text);
```

The above might print:

> Qua procella, illo eternus semel cui propello. Arma iniquus tribuo legentis victum tergo victor repeto, multus. 
> Qui volup amita porro perseverantia. Positus lacunar qui praecepio St. Incertus surgo vires nolo.
>  
> Cogo, modicus Malbodiensis defigo, maxime nutus. Spectaculum optimus defluo. Locupleto memor tamisium fodio 
> priores, reddo praecox antea, suum. Sitis orbis duro, cedo moris prolusio nimis consui iuvo, imago. Placo novus.

## How it works

Sentences are formed from a list of approximately 4000 latin words. Up to two commas are inserted per sentence. Shorter
words are favoured 50% of the time, which produces a more natural looking sentence.

Words are selected randomly. The sentences are not valid latin!
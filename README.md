# Huia

![Huia](https://raw.githubusercontent.com/Huia/Huia/master/img/Huia.png)

## Welcome to Huia.

Huia, is a programming language targetting the [Rubinius](http://rubini.us) VM.

Huia is a whitespace-aware dynamic language with a simple object model based
around traditional inheritance and closures.

Huia only has a few (global) constants for core types (such as Object, Closure.
Integer, etc).  Everything else can be made by subclassing these core types.

In addition to these two core types there are two other constants available in
the environment:

  - `Huia` which provides access to runtime features (at this stage only
     `requireFile:` and `requireCore:`).
  - `Ruby` which implements a simple object proxy allowing you to encapsulate
    a Ruby object and send and receive messages from them.  You will see that
    a large amount of the standard library is implemented this way as it
    evolves.

A simple example:

```huia
Stdout = Huia.requireCore: 'stdout'

HelloWhom = Object.extend:

  def: 'hello:' as: |whom|
    Stdout.putString: "Hello #{whom}"

helloWhom = HelloWhom.create
helloWhom.hello: "world"
```

Further documentation is available on
[the GitHub Wiki](https://github.com/Huia/Huia/wiki).

## Status

[ ![Codeship Status for Huia/Huia](https://codeship.com/projects/eca92970-7116-0132-ade1-7ac1678da8ff/status?branch=master)](https://codeship.com/projects/54569)
[![Code Climate](https://codeclimate.com/github/Huia/Huia/badges/gpa.svg)](https://codeclimate.com/github/Huia/Huia)
[![Test Coverage](https://codeclimate.com/github/Huia/Huia/badges/coverage.svg)](https://codeclimate.com/github/Huia/Huia)

## Installation

Huia is distributed as a Rubygem, as such you can either place `gem "huia"` in
your `Gemfile` or run `bundle install huia`.  Huia will only run on Rubinius
version 2.3.0 and greater.  Sorry, but if you don't have a recent Rubinius
installed, it's not going to work for you.

## Usage

You can run Huia scripts using the bundled `huia` binary or interactively
using the interactive REPL, `hirb`.

## Documentation

Further documentation is available on
[the GitHub Wiki](https://github.com/Huia/Huia/wiki).

## Extinction of the Huia

Melodious as its Māori name, the gentle Huia bird
seems a fowl lost from an ancient bestiary.

Always in pairs, their life one long low liquid interchange,
they rarely flew, but hopped and probed in deepest thickets
preening and balancing, antiphonal.

They fed upon the luscious huhu grub
under mossed and lichened podocarps
— fed and hopped so lovingly together
that if a Māori noosed one bird, its mate would come to hand.

Working together, joint custodians, His straight crow-bar beak
and Her thin curving probe, utterly unlike, conjoined
to wingle out tree-eating grubs.

Never widespread or numerous, their superb sober
plumes made mourning-wear for centuries
until Cook visited.  The stuffed ones soon
were 'musts' for lounge-rooms, though few knew
how well their natures fitted these strange bills.

Charmed by his captive pair,
Buller records how native know-how and the foreign gun
took in 600 skins from a week's work
— most of the world's remaining stock:
'Now safely on the increase'. A common bird today
in Auckland's antique shops, its loving notes
that ranged from purest whistles to what seemed
a puppy's whining call, are gone, lost,
all before the age of tapes and films.
The bird remains supreme in words
of those who loved and stuffed it.

And our museum has one — that is,
of course, a pair.

  — by Mark O'Connor.

## Contributing

1. Fork it ( https://github.com/Huia/Huia/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

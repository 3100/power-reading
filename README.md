A project template for developing a client-side application with `coffee-script`, `sass`, `slim`.
---

This uses `guard` and `sprockets` for release a product automatically:

* `coffee-script` to `javascript`
* `sass` to `css`
* `slim` to `html`

It contains `twitter-bootstrap` and `jQuery` mainly because I use them. Remove them if you don't need.

# Setup

    bundle install
    guard

It  monitors `src` folder and generate files into `public` folder.

# Goal

* Enable to use on Linux, OS X and Windows(Cygwin).
* Easy to change some template engines. (cf. Sass -> Compass)


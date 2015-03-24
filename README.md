[![Gem Version](https://badge.fury.io/rb/reportly.png)](http://badge.fury.io/rb/reportly)
[![Build Status](https://travis-ci.org/msroot/reportly.svg?branch=master)](https://travis-ci.org/msroot/reportly) 
[![Code Climate](https://codeclimate.com/github/msroot/reportly/badges/gpa.svg)](https://codeclimate.com/github/msroot/reportly)
[![Inline docs](http://inch-ci.org/github/msroot/reportly.svg?branch=master)](http://inch-ci.org/github/msroot/reportly)
[![Coverage Status](https://coveralls.io/repos/msroot/reportly/badge.svg?branch=master)](https://coveralls.io/r/msroot/reportly?branch=master)
# Reportly

Reports for Active Record results! No configurations needed

Creates a  `:report` helper method and exposed to rails console

Accepts `ActiveRecord::Relation` and `ActiveRecord::Base` objects and generates a table


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'reportly'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reportly

## Usage
From Rails console

     report User
or 

	 report Post.all

using ActiveRecord finders 

	 report Admin.where(email: 'me@localhost.com'), :id

or use the `:r` alias

	 r Translation

or by selecting fields

	r Query, :text

or by selecting fields on ActiveRecord objects

	r Query.all.first(5), :text, :id

Will generate:

	+------------------+--------------------------------------+
	| text             | id                                   |
	+------------------+--------------------------------------+
	| Ansley Bechtelar | a673cec9-b1f2-4ec4-8104-a0dbfca23771 |
	| Tevin Gerlach    | 92f6c49f-4628-4dbd-9812-4b2094151ff6 |
	| Vivien Langosh   | c452e939-4858-4113-bc3a-9db77617b11e |
	| Kadin Hahn       | 4aed4438-434c-4761-a119-ba4a6aa3e1b6 |
	| Brenda Huels     | c28c9bd4-74a9-491b-9897-12380c2cb3c8 |
	+------------------+--------------------------------------+

## Motivation

Looking for a simple method to generate a simple report i found [this](https://gist.github.com/bgreenlee/72234)
and i decided to make it a gem 

## For RockStars only

<a href="http://www.youtube.com/watch?feature=player_embedded&v=sFZjqVnWBhc
" target="_blank"><img src="http://img.youtube.com/vi/sFZjqVnWBhc/0.jpg" width="240" height="180" border="10" /></a>


## Todo

- Create a method `Model.report` to all active record objects

## Testing

run `bundle` and `rake`

## Authors

Yannis Kolovos [@yannis_kolovos](http://twitter.com/yannis_kolovos)


## Contributing

1. Fork it ( https://github.com/msroot/reportly/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## License 
MIT License Copyright (c) 2015 Yannis Kolovos

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Faster Middleman builds on Heroku
=================================

This fork of [heroku-buildpack-ruby][] works perfectly well together with the pattern presented by [middleman-heroku-static-app][].
The only difference is that it leverages [herokus build caching feature][caching].

[heroku-buildpack-ruby]: https://github.com/heroku/heroku-buildpack-ruby
[middleman-heroku-static-app]: https://github.com/indirect/middleman-heroku-static-app
[caching]: https://devcenter.heroku.com/articles/buildpack-api#caching

## Usage

```bash
heroku create --buildpack https://github.com/tmaier/heroku-buildpack-ruby-middleman.git
```

or add this buildpack to your current app

```bash
heroku config:add BUILDPACK_URL=https://github.com/tmaier/heroku-buildpack-ruby-middleman.git
```

Create a middleman site by following the example of [middleman-heroku-static-app].
You specifically need a `Gemfile`, `config.rb`, `config.ru` and a `Rakefile` with a `assets:precompile` task.

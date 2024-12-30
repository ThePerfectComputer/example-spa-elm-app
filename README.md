# About
Example demonstrating how one might architect a single page application
Elm app.

# Dependencies MacOS
```bash
brew install node elm
npm install -g uglify-js@2.4.11
```

# Building
```
make serve
```

Now open `http://localhost:8000` in your browser.

# TODO

 - [x] Add Makefile
 - [ ] Determine if `src/Body.elm` or pages in `sr/Page` should have subscription functions
 - [ ] use actix backend that maps most root requests to serve `actix_file::Files`
 - [ ] Submit to slack for feedback...
 - [ ] Refactor into router page
 - [ ] Handle back-navigation
 - [ ] Add `default.nix`

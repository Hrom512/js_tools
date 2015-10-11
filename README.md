# JsTools

## Installation

Add to Gemfile and install with bundler

```ruby
gem 'js_tools', github: 'hrom512/js_tools'
```

```bash
bundle install
```

### AjaxPopup

To use AjaxPopup plugin you need add to `app/assets/javascripts/application.js` and `app/assets/stylesheets/application.css`

```javascript
//= require jquery
//= require js_tools/ajax_popup
```

```css
*= require js_tools/ajax_popup
```

Example of using:

```javascript
var popup_login = $.ajax_popup({ name: 'login', url: '/login' });
$('a.login').click(function(){
    popup_login.show();
});
```

AjaxPopup object has two methods:
* `show()` - load content from `url` and show result as popup;
* `hide()` - hide popup.

#### Base settings

* `name` (required) - must be unique among all popups on page;
* `url` (required) - url for loading popup content;
* `width` - popup width;
* `height` - popup height.

#### Style settings

AjaxPopup has option `style`, which value must have one of these values:
* `center` (default);
* `left`;
* `right`;
* `top`;
* `bottom`.

For example:

```javascript
var popup = $.ajax_popup({
    name: 'login',
    url: '/login',
    style: 'right',
    width: '350px'
});
```

#### Animation settings

* `animation_popup` - animation type for popup;
* `animation_overlay` - animation type for overlay;
* `animation_duration` - animation duration;
* `animation_easing` - animation easing (one of values from http://easings.net/).

Options `animation_popup` and `animation_overlay` can have one of these values:

* `opacity` (default for overlay and center popup);
* `left` (default for left popup);
* `right` (default for right popup);
* `top` (default for top popup);
* `bottom` (default for bottom popup).

For example:

```javascript
var popup = $.ajax_popup({
    name: 'login',
    url: '/login',
    animation_popup: 'top',
    animation_overlay: 'opacity',
    animation_duration: 600,
    animation_easing: 'easeOutCubic'
});
```

To use custom animation easing you need add to Gemfile

```ruby
gem 'jquery-easing-rails'
```

And add to `app/assets/javascripts/application.js`

```javascript
//= require jquery.easing
```

#### Other settings

* `disable_page_scroll` (default = true) - disable page scroll when popup opened;
* `hide_on_click_overlay` (default = true) - hide popup by click on overlay;
* `use_ajax_loader` (default = true) - show ajax loader while popup content loading in process;
* `before_open` - callback, which will be executed after ajax loading and before popup open.

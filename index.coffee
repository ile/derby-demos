app = module.exports = require('derby').createApp 'component-examples', __filename
app.serverUse module, 'derby-stylus'
app.loadViews __dirname
app.loadStyles __dirname+"/css"

app.component require 'd-image-crop'
app.component require 'd-photo-upload'
app.component require 'd-light-box'
app.component require 'd-textarea'
app.component require 'd-pagedown'
app.component require 'derby-ui-toast'
app.component(require('derby-flash')(app))

toasts = [
    info: 'The fastest land animal is the Cheetah which has a recorded speed of 96–120 km/h (60–75 mph). <img style="width:200px; display: block" src="http://m.c.lnkd.licdn.com/mpr/mpr/p/7/005/085/3a7/328dc29.jpg">'
  ,
    success: 'Whew, it worked!'
  ,
    warning: 'Careful now, there!'
  ,
    error: 'Too bad, an error happened. :('
]

components = [
    name: 'd-image-crop'
    descr: '<p>A simple image cropper.</p><p><img src="https://cloud.githubusercontent.com/assets/433707/4425354/d54aab9c-45a8-11e4-8c94-ceb935c4be1d.png"></p>'
    github: "https://github.com/ile/d-image-crop"
  ,
    name: 'd-photo-upload'
    descr: '<p>A simple profile photo uploader.</p><p><img src="http://i.imgur.com/aREn5IM.png"></p>'
    github: "https://github.com/ile/d-photo-upload"
  ,
    name: 'd-light-box'
    descr: '<p>Very light lightbox.</p><p><img src="https://farm4.staticflickr.com/3766/13169486404_1342fc8c98_b.jpg" style="width:200px"></p>'
    github: "https://github.com/ile/d-light-box"
  ,
    name: 'd-textarea'
    descr: '<p>Expanding textarea.</p><p><img src="http://i.imgur.com/7g4KYyY.png"></p>'
    github: "https://github.com/ile/d-textarea"
  ,
    name: 'd-pagedown'
    descr: '<p>Markdown editor.</p><p><img src="https://cloud.githubusercontent.com/assets/433707/4852253/fa1fb49e-6079-11e4-8fdc-743660dea3cb.png"></p>'
    github: "https://github.com/ile/d-pagedown"
  ,
    name: 'derby-ui-toast'
    descr: '<p>Notification messages (toasts).</p><p><img src="https://camo.githubusercontent.com/ffd5bd926d83c1328326d0e7952fefb0d9f65c12/68747470733a2f2f662e636c6f75642e6769746875622e636f6d2f6173736574732f3433333730372f3936363435302f35373166366237322d303534392d313165332d393436622d3862303632383739643763352e706e67"></p>'
    github: "https://github.com/ile/derby-ui-toast"
  ,
    name: 'derby-flash'
    descr: '<p>Notification messages (flash). A bit similar to toasts but different.</p><p><img src="https://cloud.githubusercontent.com/assets/433707/4265716/454049a8-3c5c-11e4-9c0a-9eb06539ed0a.png"></p>'
    github: "https://github.com/ile/derby-ui-toast"
]

app.get '/', ->
  @model.set '_page.components', components
  @render 'home'
 
app.get '/:component', ->
  @upload()  if @params.component is 'd-photo-upload'
  @model.set '_page.component', find(@params.component)
  @render @params.component + '-example'

app.get '/:component/:page', ->
  @model.set '_page.component', find(@params.component)
  @render @params.component + '-example'

find = (name) ->
  a = (component for component in components when component.name is name)
  a[0]  if a?.length

app.proto.crop = (src) ->
  @model.del '_page.result'
  @model.set '_page.cropthis', src

app.proto.cropped = (e, crop) ->
  @model.del '_page.cropthis'
  @model.set '_page.result', JSON.stringify(crop)

app.proto.upload = -> @model.set '_page.photo', 'http://i.imgur.com/aREn5IM.png'

app.proto.handleError = (err) ->
  console.log(err);
  window.alert(if typeof err is 'string' then err else err?.error);

app.proto.uploaded = (result) ->
  if result?.url
    @model.set '_page.photo', result.url

app.proto.toast = ->
  i = Math.floor(Math.random() * 4)
  @model.toast toasts[i]

app.proto.flash = ->
  i = Math.floor(Math.random() * 4)
  @model.flash toasts[i]
  @app.history.push '/derby-flash/' + Date.now()
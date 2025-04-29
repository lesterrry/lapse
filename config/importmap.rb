# Pin npm packages by running ./bin/importmap

pin 'application', preload: true

pin 'registration_form', preload: true
pin 'conditional_mediation_available', preload: true
pin 'session_form', preload: true
pin 'passkey_reauthentication_handler', preload: true
pin 'turbo_events', preload: true

# todo
pin '@github/webauthn-json/browser-ponyfill', to: 'https://ga.jspm.io/npm:@github/webauthn-json@2.1.0/dist/esm/webauthn-json.browser-ponyfill.js'

pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'

pin_all_from 'app/javascript/controllers', under: 'controllers'
pin_all_from 'app/javascript/helpers', under: 'helpers'

pin 'chart.js', to: 'chart.js/dist/chart.umd.js'
pin '@kurkle/color', to: '@kurkle/color/dist/color.esm.js'

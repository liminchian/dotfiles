import ExtensionSettings from 'js/lib/ExtensionSettings'

function updateCheckbox(id, value) {
  const el = document.getElementById(id)
  if (!el) return
  el.checked = value
}

async function updateSetting(id, value) {
  if (id === 'home-page-shortcuts' || id === 'video-manager-shortcuts') {
    const keys = [
      'competitors',
      'trendalerts',
      'mostviewed',
      'channelaudit',
      'achievements',
      'academy',
    ]

    keys.forEach((key) => {
      updateCheckbox(`${id}-${key}`, value)
    })

    const payload = Object.fromEntries(
      keys.map((key) => {
        return [`${id}-${key}`, value]
      })
    )

    await ExtensionSettings.setMany(payload)
  }

  updateCheckbox(id, value)
  await ExtensionSettings.set(id, value)
}

async function loadSettings() {
  const settings = await ExtensionSettings.getSettings()
  Object.keys(settings).forEach((key) => {
    updateCheckbox(key, settings[key])
  })
}

function translate() {
  document.title = chrome.i18n.getMessage('vidIQVisionOptions')
  document.querySelectorAll('[data-i18n]').forEach(function(el) {
    const name = el.getAttribute('data-i18n')
    el.textContent = chrome.i18n.getMessage(name)
  })
}

// Add event listeners once the DOM has fully loaded by listening for the
// `DOMContentLoaded` event on the document, and adding your listeners to
// specific elements when it triggers.
document.addEventListener('DOMContentLoaded', function() {
  translate()
  loadSettings()

  const inputs = document.getElementsByTagName('input')

  for (let i = 0; i < inputs.length; i++) {
    inputs[i].addEventListener('click', function() {
      updateSetting(this.id, this.checked)
    })
  }
})

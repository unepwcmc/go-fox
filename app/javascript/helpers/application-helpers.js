const removeSpecialChars = str => str.replace(/[^a-zA-Z0-9 -]/g, '')

export const nameToId = str => removeSpecialChars(str).replace(/ /g, '-').toLowerCase()

const initializeCustomFormEventHandling = () => {
  $(document).ready(() => {
    $(window).keydown(event => {
      const ENTER_KEY_CODE = 13
      const isFormWithPreventedEnter = event => $(event.target.form).data('preventDefaultEnter')

      if(event.keyCode == ENTER_KEY_CODE && isFormWithPreventedEnter(event)) {
        event.preventDefault()
        return false
      }
    })
  })
}

export const initializeEventHandling = () => {
  initializeCustomFormEventHandling()
}

export const addStickyStyling = (elementId, stickyOffset=0, initialOffsetTop=0) => {
  const stickyElement = $('#' + elementId)

    // if(isNaN(initialOffsetTop)) {
  //   window.setTimeout(
  //     () => { initialOffsetTop = stickyElement.offset().top },
  //     100
  //   )
  // }

  $(document).scroll(() => {
    const scrollDistance = $(document).scrollTop()

    if(scrollDistance >= initialOffsetTop - stickyOffset)  {
      stickyElement.css({
        position: 'fixed',
        top: stickyOffset
      })
    } else {
        stickyElement.css('position', 'relative')
    }
  });
}

export const removeStickyStyling = elementId => {
  const nonstickyElement = $('#' + elementId)

  nonstickyElement.css('position', 'relative')
  $(document).off('scroll')
}
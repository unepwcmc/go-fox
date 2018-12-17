import { isNull } from "util";

const removeSpecialChars = str => str.replace(/[^a-zA-Z0-9 -]/g, '')

export const nameToId = str => removeSpecialChars(str).replace(/ /g, '-').toLowerCase()


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
             'top' : stickyOffset
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
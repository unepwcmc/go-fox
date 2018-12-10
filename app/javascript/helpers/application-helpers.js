const removeSpecialChars = str => str.replace(/[^a-zA-Z0-9 -]/g, "")

export const nameToId = str => removeSpecialChars(str).replace(/ /g, '-').toLowerCase()
  
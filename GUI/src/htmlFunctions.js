
var globalData = require('./global.js')
var render     = require('./render.js')
var ibom       = require('./ibom.js')

function init() {
  const boardRotation = document.getElementById('boardRotation');
  boardRotation.oninput=function()
  {
    render.setBoardRotation(boardRotation.value);
  }

  const darkModeBox = document.getElementById('darkmodeCheckbox');
  darkModeBox.onchange = function () {
    ibom.setDarkMode(darkModeBox.checked)
  }

  const silkscreenCheckbox = document.getElementById('silkscreenCheckbox');
  silkscreenCheckbox.checked=function(){
    ibom.silkscreenVisible(silkscreenCheckbox.checked)
  }
  silkscreenCheckbox.onchange=function(){
    ibom.silkscreenVisible(silkscreenCheckbox.checked)
  }

  const highlightpin1Checkbox =document.getElementById('highlightpin1Checkbox');
  highlightpin1Checkbox.onchange=function(){
    globalData.setHighlightPin1(highlightpin1Checkbox.checked);
    render.redrawCanvas(allcanvas.front);
    render.redrawCanvas(allcanvas.back);
  }

  const dragCheckbox = document.getElementById('dragCheckbox');
  dragCheckbox.checked=function(){
    globalData.setRedrawOnDrag(dragCheckbox.checked)
  }
  dragCheckbox.onchange=function(){
    globalData.setRedrawOnDrag(dragCheckbox.checked)
  }


  const combineValues = document.getElementById('combineValues');
  combineValues.onchange=function(){
    globalData.setCombineValues(combineValues.checked);
    ibom.populateBomTable();
  }

  const filter = document.getElementById('filter');
  filter.oninput=function(){
    ibom.setFilter(filter.value)
  }

  const bomCheckboxes = document.getElementById('bomCheckboxes');
  bomCheckboxes.oninput=function(){
    ibom.setBomCheckboxes(bomCheckboxes.value);
  }

  const removeBOMEntries = document.getElementById('removeBOMEntries');
  removeBOMEntries.oninput=function(){
    ibom.setRemoveBOMEntries(removeBOMEntries.value);
  }

  const additionalAttributes = document.getElementById('additionalAttributes');
  additionalAttributes.oninput=function(){
    ibom.setAdditionalAttributes(additionalAttributes.value);
  }
}

module.exports = {
  init,
};

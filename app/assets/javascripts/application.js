//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require bootbox
//= require moment
//= require bootstrap-datetimepicker
//= require locales/bootstrap-datetimepicker.zh-CN

//= require bootstrap-confirm
//= require event-load-more

// set bootbox default
bootbox.setDefaults({
  locale: "zh_CN",
  show: true,
  backdrop: true,
  closeButton: true,
  animate: true,
  className: "my-modal"
});

// datatimepicker
$.fn.datetimepicker.defaults = {
    pickDate: true,
    pickTime: true,
    useMinutes: true,
    useSeconds: false,
    useCurrent: true,
    minuteStepping: 1,
    format: 'YYYY-MM-DD hh:mm',
    minDate: '1/1/1900',
    maxDate: '1/1/2100',
    showToday: true,
    collapse: true,
    language: "zh-CN",
    defaultDate: "",
    disabledDates: false,
    enabledDates: false,
    icons:{
        time: 'fa fa-clock-o',
        date: 'fa fa-calendar',
        up: 'fa fa-chevron-up',
        down: 'fa fa-chevron-down'
    },
    useStrict: false,
    direction: "auto",
    sideBySide: false,
    daysOfWeekDisabled: false
}

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// jquery
import $ from 'jquery';

global.$ = $
global.jQuery = $

import "bootstrap"
require("@popperjs/core");
require('jquery-datetimepicker');

// The stylesheet location we created earlier
require("../stylesheets/application.scss")
require("jquery-datetimepicker/jquery.datetimepicker.css")
require('./forms/addFields')
require('./forms/removeFields')
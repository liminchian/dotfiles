!function(e,t){if("object"==typeof exports&&"object"==typeof module)module.exports=t();else if("function"==typeof define&&define.amd)define([],t);else{var n=t();for(var o in n)("object"==typeof exports?exports:e)[o]=n[o]}}(window,(function(){return function(e){var t={};function n(o){if(t[o])return t[o].exports;var r=t[o]={i:o,l:!1,exports:{}};return e[o].call(r.exports,r,r.exports,n),r.l=!0,r.exports}return n.m=e,n.c=t,n.d=function(e,t,o){n.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:o})},n.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},n.t=function(e,t){if(1&t&&(e=n(e)),8&t)return e;if(4&t&&"object"==typeof e&&e&&e.__esModule)return e;var o=Object.create(null);if(n.r(o),Object.defineProperty(o,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var r in e)n.d(o,r,function(t){return e[t]}.bind(null,r));return o},n.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return n.d(t,"a",t),t},n.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},n.p=".",n(n.s=580)}({31:function(e,t,n){"use strict";const o={set(e){const t=Object.fromEntries(Object.entries(e).map(([e,t])=>[e,JSON.stringify(t)]));return new Promise(e=>{chrome.storage.sync.set(t,e)})},get:e=>new Promise(t=>{chrome.storage.sync.get(e,n=>{let o;try{o=JSON.parse(n[e])}catch(e){}t(o)})}),async merge(e,t){const n=await o.get(e)||{};return await o.set({[e]:{...n,...t}})}};t.a=o},580:function(e,t,n){"use strict";n.r(t);var o=n(66);function r(e,t){const n=document.getElementById(e);n&&(n.checked=t)}async function a(e,t){if("home-page-shortcuts"===e||"video-manager-shortcuts"===e){const n=["competitors","trendalerts","mostviewed","channelaudit","achievements","academy"];n.forEach(n=>{r(`${e}-${n}`,t)});const a=Object.fromEntries(n.map(n=>[`${e}-${n}`,t]));await o.a.setMany(a)}r(e,t),await o.a.set(e,t)}document.addEventListener("DOMContentLoaded",(function(){document.title=chrome.i18n.getMessage("vidIQVisionOptions"),document.querySelectorAll("[data-i18n]").forEach((function(e){const t=e.getAttribute("data-i18n");e.textContent=chrome.i18n.getMessage(t)})),async function(){const e=await o.a.getSettings();Object.keys(e).forEach(t=>{r(t,e[t])})}();const e=document.getElementsByTagName("input");for(let t=0;t<e.length;t++)e[t].addEventListener("click",(function(){a(this.id,this.checked)}))}))},66:function(e,t,n){"use strict";var o=n(31);const r={"rating-bar":!0,"toolbar-stats":!0,"home-page-shortcuts":!0,"home-page-shortcuts-competitors":!0,"home-page-shortcuts-trendalerts":!0,"home-page-shortcuts-mostviewed":!0,"home-page-shortcuts-channelaudit":!0,"home-page-shortcuts-achievements":!0,"home-page-shortcuts-academy":!0,"video-manager-shortcuts":!0,"video-manager-shortcuts-competitors":!0,"video-manager-shortcuts-trendalerts":!0,"video-manager-shortcuts-mostviewed":!0,"video-manager-shortcuts-channelaudit":!0,"video-manager-shortcuts-achievements":!0,"video-manager-shortcuts-academy":!0,"firefox-allow-tracking":!1},a={async getSettings(){const e=await o.a.get("vidiq_options")||{};return{...r,...e}},async get(e){return(await this.getSettings())[e]},async set(e,t){await o.a.merge("vidiq_options",{[e]:t})},async setMany(e){await o.a.merge("vidiq_options",e)}};t.a=a}})}));
/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	"use strict";

	var sites = __webpack_require__(1),
	    Filter = __webpack_require__(2),
	    ListFormatter = __webpack_require__(3),
	    LocalStorageStore = __webpack_require__(4);

	function hostname(url) {
	    var parser = document.createElement("a");
	    parser.href = url;
	    return parser.hostname;
	}

	function block(url) {
	    var filter = new Filter(),
	        ret = false,
	        domain = hostname(url),
	        key = "tmpWhitelist";

	    filter.appendBlacklist(sites);
	    filter.appendBlacklist(ListFormatter.parse(LocalStorageStore.userBlacklist));

	    filter.appendWhitelist(ListFormatter.parse(LocalStorageStore.userWhitelist));

	    if (filter.match(domain)) {
	        var Whitelist;
	        try {
	            Whitelist = JSON.parse(localStorage.getItem(key) || "");
	        } catch (e) {
	            Whitelist = {};
	        }

	        if (Whitelist.hasOwnProperty(domain)) {
	            var timestamp = new Date().getTime();
	            var threshold = 10 * 60 * 1000; // Ten minutes
	            if (timestamp - Whitelist[domain] > threshold) {
	                delete Whitelist[domain];

	                try {
	                    localStorage.setItem(key, JSON.stringify(Whitelist));
	                } catch (err) {
	                    console.error(err);
	                }
	            }
	        }

	        if (!Whitelist.hasOwnProperty(domain)) {
	            ret = true;
	        }
	    }
	    return ret;
	}

	function handle(tab) {
	    if (block(tab.url)) {
	        chrome.tabs.update(tab.id, { url: "stop.html?to=" + encodeURIComponent(tab.url) });
	    }
	}

	chrome.webRequest.onBeforeRequest.addListener(function (info) {
	    var cancel = false;

	    if (!LocalStorageStore.isWebRequestFilterBlocked) {
	        cancel = block(info.url);
	    }

	    return { cancel: cancel };
	}, {
	    urls: ["*://*/*"]
	}, ["blocking"]);

	chrome.tabs.onCreated.addListener(function (tab) {
	    handle(tab);
	});

	chrome.tabs.onUpdated.addListener(function (tabId, changeInfo, tab) {
	    handle(tab);
	});

/***/ },
/* 1 */
/***/ function(module, exports) {

	/* Rules:

	   1. Don't include "www" / "ww" prefix
	   2. Don't sort the list. Maintainer will do it before next release.
	 */

	"use strict";

	var sites = ["163nvren.com", "360doc.com", "7jiu.com.hk", "a-gui.com", "aboutfighter.com", "apple01.net", "appnews.fanswong.com", "asia01.club", "axn2000.blogspot.*", "babymaycry.com", "baiyongqin.cc", "bananadaily.net", "beauties.life", "beefun01.com", "biginfo4u.com", "bignews01.com", "bomb01.com", "bottle01.tw", "bubuko.com", "bucktop.com", "bunnygo.net", "buzz01.com", "buzzhand.com", "buzzhand.net", "buzzjoker.com", "buzzlife.com.tw", "buzznews.news", "ccolorsky.blogspot.com", "changepw.com", "chaxf.com", "chunew.com", "cibeiwen.com", "circle01.com", "classicofloves.com", "clickme.net", "cmoney.tw", "coco01.net", "cocomy.net", "cocotw.net", "contw.com", "dailyfun.cc", "dailyhearter.net", "daleba.net", "daliulian.net", "dayhot.news", "dayspot.net", "discoss.com", "dnbcw.info", "dongqiuxiang.net", "dsy39.com", "eazon.com", "enews.com.tw", "eryunews.com", "ezgoe.com", "eznewlife.com", "ezp9.com", "ezvivi.com", "ezvivi2.com", "f.duckhk.com", "faminereports.blogspot.*", "fanli7.net", "fullyu.com", "fun.youngboysgirls.com", "fun01.cc", "fun01.net", "funnies.online", "funssy.com", "funvdo01.com", "getez.info", "getfunfun.com", "getjoyz.com", "gigacircle.com", "gigcasa.com", "gjoyz.com", "guowenme.cc", "guudo.cn", "handread.cc", "haolookr.com", "happies.news", "happiness.beauties.life", "happyeverydaymovie.com", "healthalover.com", "hehuancui.com", // buzz01
	"hk.maheshbhusal.com.np", "hkwall.com", "honey99.net", "hothk.com", "hotnews.hk", "hottimes.org", "housekook.com", "how01.com", "howfunny.org", "hssszn.com", "icovideos.com", "ideapit.com", "ifuun.com", "ihot.news", "ilife97.com", "ilife99.com", "immediates.net", "ipetgroup.com", "ireaded.com", "ispot.news", "izhentoo.cc", "jimmyfans.com", "juksy.com", "justfenxiang.net", "justhotnews.site", "kan.world", "kikinote.net", "kknews.cc", "kuso01.tv", "laughbombclub.com", "letu.life", "life.com.tw", "life.cx", // This domain will redirect to life.tw
	"life.tw", "likea.ezvivi.com", "line-share.tw", "mama.tw", "mamicode.com", "mango01.com", "maoanbo.net", "media8.me", "medialnk.com", "menclub.co", "metalballs.com", "mili010.com", "mili010.net", "mimi186.com", "ml.design-fabrica.com", // Whole HK
	"ml.yubhar.com", "money83.com", "moneyaaa.com", "muratify.cc", "myfbshare.net", "mytimes.org", "news.95lady.com", "news.knowing.asia", "news.qzapp.net", "news01.cc", "newstube01.tv", "novelfeed.com", "ohwonews.com", "onefunnyjoke.com", "onnewlife.com", "orange01.org", "pcasg.com", "peopleinsider.blogspot.*", "peopleinsider.net", "picallies.com", "plays01.com", "post01.com", "programgo.com", "ptt01.cc", "pttbook.com", "push01.com", "push01.net", "qianqu.cc", "qilook.com", "qiqu.news", "quiz321.com", "qzapp.net", "read01.com", "reg.youthwant.com.tw", "share.youthwant.com.tw", "share001.com", "share001.net", "share2fb.net", "shareba.com", "shareonion.com", "sharetify.com", "sk2zone.com", "spicemami.com", "story.bazzfly.com", "superfun-e.com", "teepr.com", "thefundaily.com", "thegreatdaily.com", "thegreendaily.net", "thehealthdaily.org", "tipelse.com", "toments.com", "ttshow.tw", "tw.anyelse.com", "twgreatdaily.com", "vdoobv.com", "video-lab.net", //Whole HK,
	"viralane.com", "whatfunny.org", "wholehk.com", "whyhow.online", "womanaaa.com", "wonder4.co", "ww.happy123.org", "ww.share001.org", "xianso.com", "xibao.tw", "xuxianghui.cc", "xuxinfang.xyz", "yibihan.net", "ymiit.com", "yourbabb.com", "yourfacts.club", // FB Share trap
	"yourhope.info", "youthwant.com", "youthwant.com.tw", "youthwant.ufc.com.tw", "youthwant.xnnow.com", "zhentoo.com", "zhentoo.net", "zhoucuimei.cc", "zhulinlin.net", "8im.me", "8md.me", "buzzbooklet.com", "dungwa.com", "gjoyz.co", "hkappleweekly.com", "hktimes.org", "imama.tw", "interestingpo.com", "meishuile.com", "nowlooker.com", "ourstarsky.com", "post01.net", "readhouse.net", "thehealther.com", "topnews8.com", "twtimes.org", "bc3ts.com", "cacanews.com", "goodlifeyou.bumbnews.com", "gooread.com", "gyfunnews.com", "happytify.cc", "lovelifes.net", "moretify.com", "myfunnews.com", "pixpo.net", "please.news", "uuread.cc", "lookforward.cc", "orgs.one", "ballgametime.com", "bml.orgs.one", "buzzer123.com", "chinesealliance.net", "crazy-photoshop.com", "ebcbuzz.com", "flxdaily.com", "gleenow.com", "goodtimes.my/", "happytify.net", "health1.tw", "jiankanghou.com", "lifeyet.com", "loveshare.online", "pineapple99.com", "ps.loveshares.cc"];

	module.exports = sites;

/***/ },
/* 2 */
/***/ function(module, exports) {

	"use strict";

	Object.defineProperty(exports, "__esModule", {
	    value: true
	});

	var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();

	function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

	var Filter = (function () {
	    function Filter() {
	        _classCallCheck(this, Filter);

	        this._Blacklist = [];
	        this._Whitelist = [];
	        this._BlacklistRx = [];
	        this._WhitelistRx = [];
	    }

	    _createClass(Filter, [{
	        key: "appendBlacklist",
	        value: function appendBlacklist(list) {
	            for (var i in list) {
	                var item = list[i];
	                var rx = this.createRegExp(item);
	                this._Blacklist.push(item);
	                this._BlacklistRx.push(rx);
	            }
	        }
	    }, {
	        key: "appendWhitelist",
	        value: function appendWhitelist(list) {
	            for (var i in list) {
	                var item = list[i];
	                var rx = this.createRegExp(item);
	                this._Whitelist.push(item);
	                this._WhitelistRx.push(rx);
	            }
	        }
	    }, {
	        key: "match",
	        value: function match(hostname) {
	            var ret = false;
	            hostname = hostname.toLowerCase();
	            for (var i in this._BlacklistRx) {
	                var pattern = this._BlacklistRx[i];
	                if (hostname.match(pattern)) {

	                    ret = true;

	                    for (var j in this._WhitelistRx) {
	                        if (hostname.match(this._WhitelistRx[j])) {
	                            ret = false;
	                            break;
	                        }
	                    }

	                    break;
	                }
	            }
	            return ret;
	        }
	    }, {
	        key: "createRegExp",
	        value: function createRegExp(pattern) {
	            var replaced;

	            // Take out http[s]:// prefix
	            replaced = pattern.replace(/^http[s]*:*\/*/, "");

	            replaced = replaced.replace(/\./g, "\\.").replace(/\*/g, ".*");
	            var rx = new RegExp("^[a-z0-9-\.]*\\.+" + replaced + "$|^" + replaced + "$");

	            return rx;
	        }
	    }]);

	    return Filter;
	})();

	exports["default"] = Filter;
	;
	module.exports = exports["default"];

/***/ },
/* 3 */
/***/ function(module, exports) {

	"use strict";

	Object.defineProperty(exports, "__esModule", {
	    value: true
	});

	var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();

	function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

	var ListFormatter = (function () {
	    function ListFormatter() {
	        _classCallCheck(this, ListFormatter);
	    }

	    _createClass(ListFormatter, null, [{
	        key: "parse",
	        value: function parse(input) {
	            if (!input) {
	                input = "";
	            }

	            var token = String(input).split(/[ ,\n]/);
	            for (var i = token.length - 1; i >= 0; i--) {
	                var item = token[i].trim();
	                if (item === "") {
	                    token.splice(i, 1);
	                } else {
	                    token[i] = item;
	                }
	            }

	            return token;
	        }
	    }, {
	        key: "stringify",
	        value: function stringify(input) {
	            if (input === null) {
	                input = [];
	            }
	            if (!Array.isArray(input)) {
	                return String(input);
	            }
	            return input.join("\n");
	        }
	    }]);

	    return ListFormatter;
	})();

	exports["default"] = ListFormatter;
	module.exports = exports["default"];

/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	"use strict";

	Object.defineProperty(exports, "__esModule", {
	    value: true
	});

	var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();

	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }

	function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

	var _ListFormatter = __webpack_require__(3);

	var _ListFormatter2 = _interopRequireDefault(_ListFormatter);

	//10 minus
	var threshold = 10 * 60 * 1000;

	function _getArray(key) {
	    var ret = [];
	    try {
	        ret = JSON.parse(localStorage.getItem(key));
	    } catch (e) {
	        ret = [];
	    }

	    if (!Array.isArray(ret)) {
	        ret = [];
	    }

	    return ret;
	}

	var LocalStorageStore = (function () {
	    function LocalStorageStore() {
	        _classCallCheck(this, LocalStorageStore);
	    }

	    _createClass(LocalStorageStore, null, [{
	        key: "blockWebRequestFilter",

	        /// Disable the Web Request Filter for a while

	        value: function blockWebRequestFilter() {
	            var timestamp = new Date().getTime();

	            localStorage.setItem("blockWebRequestFilter", timestamp);
	        }
	    }, {
	        key: "isWebRequestFilterBlocked",
	        get: function get() {
	            var ret = false,
	                value = -1,
	                timestamp = new Date().getTime();

	            value = parseInt(localStorage.getItem("blockWebRequestFilter"));
	            if (value === NaN || value <= 0) return false;

	            return timestamp - value < threshold;
	        }
	    }, {
	        key: "userBlacklist",
	        get: function get() {
	            return _getArray("userBlacklist");
	        },
	        set: function set(val) {
	            localStorage.setItem("userBlacklist", JSON.stringify(val));
	        }
	    }, {
	        key: "userWhitelist",
	        get: function get() {
	            return _getArray("userWhitelist");
	        },
	        set: function set(val) {
	            localStorage.setItem("userWhitelist", JSON.stringify(val));
	        }
	    }]);

	    return LocalStorageStore;
	})();

	exports["default"] = LocalStorageStore;
	module.exports = exports["default"];

/***/ }
/******/ ]);
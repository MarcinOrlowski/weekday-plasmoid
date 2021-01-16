var defaultTheme='__default__'
var themes = {
/*
	"<UNIQUE-ID>": {
		"theme":{"name":"<NAME>"},
		"widget":{"bg":"#00000000"},
		"lastDayMonth":{"enabled":true,"bg":"#FFafe109"},

		"today":{"fg":"#FFffffff", "bg":"#FFff006e", "bold":true, "italic":false},
		// todayXXX can be ommitied if "enabled: false". The Today values are the fallback
		"todaySaturday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false},
		"todaySunday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false}

		"past":{"fg":"#FFffffff", "bg":"#00000000", "bold":false, "italic":false},
		// pastXXX can be ommitied if "enabled: false". The past values are the fallback
		"pastSaturday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false},
		"pastSunday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false}

		"future":{"fg":"#FFffffff", "bg":"#00000000", "bold":false, "italic":false},
		// futureXXX can be ommitied if "enabled: false". The future values are the fallback
		"futureSaturday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false}
	}
*/

	'__default__': {
		"theme":{"name":"Default"},
		"widget":{"enabled":true,"bg":"#00000000"},
		"lastDayMonth":{"enabled":true,"bg":"#FFafe109"},
		"today":{"enabled":true,"fg":"#FFffffff","bg":"#FFff006e","bold":true,"italic":false},
		"past":{"enabled":true,"fg":"#FFffffff","bg":"#00000000","bold":false,"italic":false},
		"future":{"enabled":true,"fg":"#FFffffff","bg":"#00000000","bold":false,"italic":false},
	},
	"amber": {
		"theme":{"name":"Amber"},
		"widget":{"enabled":true,"bg":"#00000000"},
		"lastDayMonth":{"enabled":true,"bg":"#FFff006e"},
		"today":{"enabled":true,"fg":"#f0e513","bg":"#5500ff","bold":true,"italic":false},
		"past":{"enabled":true,"fg":"#a3705e","bg":"#783e23","bold":false,"italic":false},
		"future":{"enabled":true,"fg":"#752503","bg":"#d2900c","bold":true,"italic":false},
	},
	"accented-bw-dark": {
		"theme":{"name":"B&W Accented"},
		"widget":{"enabled":true,"bg":"#253137"},
		"lastDayMonth":{"enabled":true,"bg":"#FFff006e"},
		"today":{"enabled":true,"fg":"#232323","bg":"#b4b4b4","bold":true,"italic":false},
		"past":{"enabled":true,"fg":"#50ffffff","bg":"#00000000","bold":false,"italic":false},
		"future":{"enabled":true,"fg":"#ffffff","bg":"#00253137","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#c8ff007f","bg":"#00253137","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#c80064","bg":"#00253137","bold":true,"italic":false}
	},
	"blue-crayola": {
		"theme":{"name":"Blue Crayola"},
		"widget":{"bg":"#005991"},
		"lastDayMonth":{"enabled":true,"bg":"#a4e541"},
		"past":{"fg":"#b5b5b6","bg":"#005488","bold":false,"italic":false},
		"today":{"fg":"#161515","bg":"#e4cc37","bold":true,"italic":false},
		"future":{"fg":"#fffffa","bg":"#1e91d6","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#ceffc6","bg":"#1e91d6","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#ceffc6","bg":"#1e91d6","bold":true,"italic":false}
	},
	"brown-sugar": {
		"theme": {"name":"Brown Sugar"},
		"widget":{"bg":"#373f51"},
		"lastDayMonth":{"enabled":true,"bg":"#22ff00"},
		"past":{"fg":"#151515","bg":"#beb7a4","bold":false,"italic":false},
		"today":{"fg":"#a1674a","bg":"#ffffff","bold":true,"italic":false},
		"future":{"fg":"#ffffff","bg":"#a63a50","bold":true,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#c8ffffff","bg":"#ba6e6e","bold":false,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#c8ffffff","bg":"#ba6e6e","bold":false,"italic":false}
	},
	"bw-dark": {
		"theme":{"name":"B&W"},
		"widget":{"enabled":true,"bg":"#253137"},
		"lastDayMonth":{"enabled":true,"bg":"#FFffffff"},
		"today":{"enabled":true,"fg":"#232323","bg":"#b4b4b4","bold":true,"italic":false},
		"past":{"enabled":true,"fg":"#50ffffff","bg":"#00000000","bold":false,"italic":false},
		"future":{"enabled":true,"fg":"#ffffff","bg":"#00253137","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#ffffff","bg":"#707070","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#ffffff","bg":"#707070","bold":true,"italic":false}
	},
	"dark-lava": {
		"theme":{"name":"Dark Lava"},
		"widget":{"bg":"#4b4c4d"},
		"lastDayMonth":{"enabled":true,"bg":"#ff006e"},
		"past":{"fg":"#9f9f80","bg":"#524632","bold":false,"italic":false},
		"today":{"fg":"#19150f","bg":"#fff23c","bold":true,"italic":false},
		"future":{"fg":"#30291d","bg":"#dedbd8","bold":true,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#c8524632","bg":"#c3c49e","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#c8524632","bg":"#c3c49e","bold":true,"italic":false}
	},
	"feldgrau": {
		"theme":{"name":"Feldgrau"},
		"widget":{"bg":"#5b6c5d"},
		"lastDayMonth":{"enabled":true,"bg":"#e2e2e2"},
		"past":{"fg":"#2a1f2d","bg":"#5b6c5d","bold":false,"italic":false},
		"today":{"fg":"#e4e2e3","bg":"#3b2c35","bold":true,"italic":false},
		"future":{"fg":"#ffffff","bg":"#00000000","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#ffd950","bg":"#000000","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#ffd950","bg":"#00000000","bold":true,"italic":false}
	},
	"forest": {
		"theme":{"name":"Forest"},
		"widget":{"enabled":true,"bg":"#2e3136"},
		"lastDayMonth":{"enabled":true,"bg":"#FFaaff00"},
		"today":{"enabled":true,"fg":"#ffffff","bg":"#ff006e","bold":true,"italic":false},
		"past":{"enabled":true,"fg":"#50ffffff","bg":"#482d3e","bold":false,"italic":false},
		"future":{"enabled":true,"fg":"#ffffff","bg":"#327851","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#c8ffff7f","bg":"#24583b","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#c8ffff7f","bg":"#24583b","bold":true,"italic":false}
	},
	"lapis-lazuli": {
		"theme":{"name": "Lapis Lazuli"},
		"widget":{"bg":"#beb7a4"},
		"lastDayMonth":{"enabled":true,"bg":"#66ff14"},
		"past":{"fg":"#151515","bg":"#beb7a4","bold":false,"italic":false},
		"today":{"fg":"#ffffff","bg":"#ff7f11","bold":true,"italic":false},
		"future":{"fg":"#ffffff","bg":"#2660a4","bold":true,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#c8ffffff","bg":"#802392","bold":false,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#c8ffffff","bg":"#802392","bold":false,"italic":false}
	},
	"lavender": {
		"theme":{"name":"Lavender"},
		"widget":{"bg":"#4b4c4d"},
		"lastDayMonth":{"enabled":true,"bg":"#ff006e"},
		"past":{"fg":"#856084","bg":"#c8d4adcf","bold":true,"italic":false},
		"today":{"fg":"#212121","bg":"#8ff5a2","bold":true,"italic":false},
		"future":{"fg":"#212121","bg":"#d4adcf","bold":true,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#ceffc6","bg":"#856084","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#ceffc6","bg":"#856084","bold":true,"italic":false}
	},
	"light-periwinkle": {
		"theme":{"name":"Light Periwinkle"},
		"widget":{"bg":"#a3c3d9"},
		"lastDayMonth":{"enabled":true,"bg":"#ff006e"},
		"past":{"fg":"#1b1b1b","bg":"#a3c3d9","bold":false,"italic":false},
		"today":{"fg":"#eee4e4","bg":"#993955","bold":true,"italic":false},
		"future":{"fg":"#444444","bg":"#ccd6eb","bold":true,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#ceffc6","bg":"#1e91d6","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#ceffc6","bg":"#1e91d6","bold":true,"italic":false}
	},
	"olive": {
		"theme": {"name":"Olive"},
		"widget":{"bg":"#292c25"},
		"lastDayMonth":{"enabled":true,"bg":"#ff006e"},
		"past":{"fg":"#865f4f","bg":"#4a5043","bold":true,"italic":false},
		"today":{"fg":"#070602","bg":"#ffcb47","bold":true,"italic":false},
		"future":{"fg":"#ffffff","bg":"#337851","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#0b022d","bg":"#a37500","bold":false,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#0b022d","bg":"#a37500","bold":false,"italic":false}
	},
	"orchid": {
		"theme":{"name":"Orchid"},
		"widget":{"bg":"#4a3572"},
		"lastDayMonth":{"enabled":true,"bg":"#f8ba00"},
		"past":{"fg":"#dadada","bg":"#d664be","bold":false,"italic":false},
		"today":{"fg":"#bd2d87","bg":"#ffffff","bold":true,"italic":false},
		"future":{"fg":"#352b4d","bg":"#df99f0","bold":true,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#b191ff","bg":"#a30015","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#b191ff","bg":"#a30015","bold":true,"italic":false}
	},
	"princeton-orange": {
		"theme":{"name":"Princeton Orange"},
		"widget":{"bg":"#38726c"},
		"lastDayMonth":{"enabled":true,"bg":"#ff006e"},
		"past":{"fg":"#fffbbb","bg":"#d34e24","bold":false,"italic":false},
		"today":{"fg":"#563f1b","bg":"#f7f052","bold":true,"italic":false},
		"future":{"fg":"#ffffff","bg":"#00000000","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#ffd950","bg":"#563f1b","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#ffd950","bg":"#563f1b","bold":true,"italic":false}
	},
	"purple-rain": {
		"theme":{"name":"Purple Rain"},
		"widget":{"bg":"#431659"},
		"lastDayMonth":{"enabled":true,"bg":"#f400bb"},
		"past":{"fg":"#8c866f","bg":"#210b2c","bold":false,"italic":false},
		"today":{"fg":"#210b2c","bg":"#bc96e6","bold":true,"italic":false},
		"future":{"fg":"#ae759f","bg":"#00000000","bold":false,"italic":false},
		"futureSaturday":{"enabled":false,"fg":"#ffffff","bg":"#00000000","bold":false,"italic":false},
		"futureSunday":{"enabled":false,"fg":"#ffffff","bg":"#00000000","bold":false,"italic":false}
	},
	"red-wine": {
		"theme":{"name":"Red Wine"},
		"widget":{"bg":"#fffffa"},
		"lastDayMonth":{"enabled":true,"bg":"#aaaa00"},
		"past":{"fg":"#b6b6b3","bg":"#40434e","bold":false,"italic":false},
		"today":{"fg":"#912f40","bg":"#fffffa","bold":true,"italic":false},
		"future":{"fg":"#fffffa","bg":"#912f40","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#797f93","bg":"#702632","bold":false,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#797f93","bg":"#702632","bold":false,"italic":false}
	},
	"rusty": {
		"theme": {"name": "Rusty"},
		"widget":{"bg":"#691e06"},
		"lastDayMonth":{"enabled":true,"bg":"#c4d318"},
		"past":{"fg":"#fbba72","bg":"#691e06","bold":false,"italic":false},
		"today":{"fg":"#691e06","bg":"#f8b871","bold":true,"italic":false},
		"future":{"fg":"#ffffff","bg":"#ca5310","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#cbcbcb","bg":"#b49d3f0c","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#cbcbcb","bg":"#b49d3f0c","bold":true,"italic":false}
	},
	"sea-blue": {
		"theme":{"name":"Sea Blue"},
		"widget":{"enabled":true,"bg":"#2e3136"},
		"lastDayMonth":{"enabled":true,"bg":"#FF00fbff"},
		"today":{"enabled":true,"fg":"#eeeeee","bg":"#ff006e","bold":true,"italic":false},
		"past":{"enabled":true,"fg":"#50ffffff","bg":"#00000000","bold":false,"italic":false},
		"future":{"enabled":true,"fg":"#ffffff","bg":"#3a738b","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#c8ffffff","bg":"#326478","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#c8ffffff","bg":"#326478","bold":true,"italic":false}
	},
	"sunset": {
		"theme":{"name":"Sunset"},
		"widget":{"bg":"#74546b"},
		"lastDayMonth":{"enabled":true,"bg":"#2effee"},
		"past":{"enabled":true,"fg":"#ad7c66","bg":"#74546b","bold":true,"italic":false},
		"today":{"enabled":true,"fg":"#ffb997","bg":"#833b61","bold":true,"italic":false},
		"future":{"fg":"#ffffff","bg":"#337851","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#0b022d","bg":"#f67e7d","bold":false,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#0b022d","bg":"#f67e7d","bold":false,"italic":false}
	},
	"violet": {
		"theme":{"name":"Violet"},
		"widget":{"enabled":true,"bg":"#2e3136"},
		"lastDayMonth":{"enabled":true,"bg":"#FF2effee"},
		"today":{"enabled":true,"fg":"#ffffff","bg":"#ff006e","bold":true,"italic":false},
		"past":{"enabled":true, "fg":"#50ffffff","bg":"#3c66134c","bold":false,"italic":false},
		"future":{"enabled":true,"fg":"#ffffff","bg":"#337851","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false}
	}

}


var defaultTheme='__default__'
var custom='__custom__'
var themes = {
/*
	"<UNIQUE-ID>": {
		"theme":{"name":"<NAME>"},
		"widget":{"bg":"#00000000"},

		"today":{"fg":"#FFffffff", "bg":"#FFff006e", "bold":true, "italic":false},
		// todayXXX can be ommitied if "enabled: false". The Today values are the fallback
		"todaySaturday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false},
		"todaySunday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false}

		"pastDay":{"fg":"#FFffffff", "bg":"#00000000", "bold":false, "italic":false},
		// pastXXX can be ommitied if "enabled: false". The pastDay values are the fallback
		"pastSaturday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false},
		"pastSunday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false}

		"futureDay":{"fg":"#FFffffff", "bg":"#00000000", "bold":false, "italic":false},
		// futureXXX can be ommitied if "enabled: false". The futureDay values are the fallback
		"futureSaturday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false}
	}
*/

	'__default__': {
		"theme":{"name":"Default"},
		"widget":{"bg":"#00000000"},
		"today":{"fg":"#FFffffff", "bg":"#FFff006e", "bold":true, "italic":false},
		"pastDay":{"fg":"#FFffffff", "bg":"#00000000", "bold":false, "italic":false},
		"futureDay":{"fg":"#FFffffff", "bg":"#00000000", "bold":false, "italic":false},
	},
	"violet": {
		"theme":{"name":"Violet"},
		"widget":{"bg":"#2e3136"},
		"today":{"fg":"#ffffff","bg":"#ff006e","bold":true,"italic":false},
		"pastDay":{"fg":"#50ffffff","bg":"#3c66134c","bold":false,"italic":false},
		"futureDay":{"fg":"#ffffff","bg":"#337851","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#c8ffff7f","bg":"#c06252c6","bold":false,"italic":false}
	},
	"amber": {
		"theme":{"name":"Amber"},
		"widget":{"bg":"#00000000"},
		"today":{"fg":"#f0e513","bg":"#5500ff","bold":true,"italic":false},
		"pastDay":{"fg":"#a3705e","bg":"#783e23","bold":false,"italic":false},
		"futureDay":{"fg":"#752503","bg":"#d2900c","bold":true,"italic":false},
	},
	"forest": {
		"theme":{"name":"Forest"},
		"widget":{"bg":"#2e3136"},
		"today":{"fg":"#ffffff","bg":"#ff006e","bold":true,"italic":false},
		"pastDay":{"fg":"#50ffffff","bg":"#482d3e","bold":false,"italic":false},
		"futureDay":{"fg":"#ffffff","bg":"#327851","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#c8ffff7f","bg":"#24583b","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#c8ffff7f","bg":"#24583b","bold":true,"italic":false}
	},
	"sea-blue": {
		"theme":{"name":"Sea Blue"},
		"widget":{"bg":"#2e3136"},"today":{"fg":"#eeeeee","bg":"#ff006e","bold":true,"italic":false},
		"pastDay":{"fg":"#50ffffff","bg":"#00000000","bold":false,"italic":false},
		"futureDay":{"fg":"#ffffff","bg":"#3a738b","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#c8ffffff","bg":"#326478","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#c8ffffff","bg":"#326478","bold":true,"italic":false}
	},
	"accented-bw-dark": {
		"theme":{"name":"B&W Accented"},
		"widget":{"bg":"#253137"},
		"today":{"fg":"#232323","bg":"#b4b4b4","bold":true,"italic":false},
		"pastDay":{"fg":"#50ffffff","bg":"#00000000","bold":false,"italic":false},
		"futureDay":{"fg":"#ffffff","bg":"#00253137","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#c8ff007f","bg":"#00253137","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#c80064","bg":"#00253137","bold":true,"italic":false}
	},
	"bw-dark": {
		"theme":{"name":"B&W"},
		"widget":{"bg":"#253137"},
		"today":{"fg":"#232323","bg":"#b4b4b4","bold":true,"italic":false},
		"pastDay":{"fg":"#50ffffff","bg":"#00000000","bold":false,"italic":false},
		"futureDay":{"fg":"#ffffff","bg":"#00253137","bold":false,"italic":false},
		"futureSaturday":{"enabled":true,"fg":"#ffffff","bg":"#707070","bold":true,"italic":false},
		"futureSunday":{"enabled":true,"fg":"#ffffff","bg":"#707070","bold":true,"italic":false}
	}

}


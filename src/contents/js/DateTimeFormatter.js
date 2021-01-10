function pad(str, len) {
	if (len === undefined) len = 2
	len = len * -1
	return ('0000000' + str).substr(len)
}

function ucfirst(string) {
    return (string.length > 1) ? string.substr(0, 1).toUpperCase() + string.substr(1) : string.toUpperCase();
}

// https://stackoverflow.com/a/8619946/1235698
function getDayOfYear() {
	var now = new Date()
	var start = new Date(now.getFullYear(), 0, 0)
	var diff = (now - start) + ((start.getTimezoneOffset() - now.getTimezoneOffset()) * 60 * 1000)
	var oneDay = 1000 * 60 * 60 * 24
	var day = Math.floor(diff / oneDay)
	return day
}

/**
 ** localeName: locale name to use (i.e. 'en_US', 'pl_PL'). System default will be used if not provided.
 */
function format(template, localeName) {
	if (localeName === undefined) localeName = ''
		
	var locale = Qt.locale(localeName)
	var map = {}
	var now = new Date()

	// https://doc.qt.io/qt-5/qml-qtqml-qt.html#formatDateTime-method
	map['yyyy'] = Qt.formatDate(now, 'yyyy')
	map['yy'] = Qt.formatDate(now, 'yy')
	map['MMM'] = now.toLocaleDateString(locale, 'MMMM')
	map['MM'] = now.toLocaleDateString(locale, 'MMM')
	map['M'] = map['MM'].substr(0, 1)
	map['mm'] = Qt.formatDate(now, 'MM')
	map['m'] = Qt.formatDate(now, 'M')
//	ss
//	s
	map['DDD'] = now.toLocaleDateString(locale, 'dddd')
	map['DD'] = now.toLocaleDateString(locale, 'ddd')
	map['D'] = map['DD'].substr(0, 1)
	map['dd'] = Qt.formatDate(now, 'dd')
	map['d'] = Qt.formatDate(now, 'd')
	map['dy'] = getDayOfYear()

	// FIXME: add support for any day being first day of the week for all d* fields (for now it's Sunday)
	map['dw'] = now.getDay()+1
//	wm
//	wy
	map['hh'] = pad(now.getHours())
	map['h'] = now.getHours()
	map['kk'] = pad(now.getHours()%12)
	map['k'] = now.getHours()
	map['ii'] = pad(now.getMinutes())
	map['i'] = now.getMinutes()
	map['AA'] = Qt.formatTime(now, 'AP')
	map['A'] = map['AA'].substr(0, 1)
	map['aa'] = map['AA'].toLowerCase()
	map['a'] = map['aa'].substr(0, 1)
	map['Aa'] = map['A'] + map['aa'].substr(-1)

//	map['t'] = Qt.formatTime(now, 't')
	map['t'] = now.toLocaleTimeString(locale, 't')

//	system short format
//	system long format
//	default system format

	for(var key in map) {
		template = template.replace(new RegExp(`%${key}%`, 'g'), map[key])

		template = template.replace(new RegExp(`%${key}:U%`, 'g'), map[key].toString().toUpperCase())
		template = template.replace(new RegExp(`%${key}:L%`, 'g'), map[key].toString().toLowerCase())
		template = template.replace(new RegExp(`%${key}:u%`, 'g'), ucfirst(map[key].toString()))
	}

	return template
}


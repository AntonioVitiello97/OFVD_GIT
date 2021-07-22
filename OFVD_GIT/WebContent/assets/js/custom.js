const countryList = [
  "Afghanistan",
  "Aland Islands",
  "Albania",
  "Algeria",
  "American Samoa",
  "Andorra",
  "Angola",
  "Anguilla",
  "Antarctica",
  "Antigua and Barbuda",
  "Argentina",
  "Armenia",
  "Aruba",
  "Australia",
  "Austria",
  "Azerbaijan",
  "Bahamas",
  "Bahrain",
  "Bangladesh",
  "Barbados",
  "Belarus",
  "Belgium",
  "Belize",
  "Benin",
  "Bermuda",
  "Bhutan",
  "Bolivia, Plurinational State of",
  "Bonaire, Sint Eustatius and Saba",
  "Bosnia and Herzegovina",
  "Botswana",
  "Bouvet Island",
  "Brazil",
  "British Indian Ocean Territory",
  "Brunei Darussalam",
  "Bulgaria",
  "Burkina Faso",
  "Burundi",
  "Cabo Verde",
  "Cambodia",
  "Cameroon",
  "Canada",
  "Cayman Islands",
  "Central African Republic",
  "Chad",
  "Chile",
  "China",
  "Christmas Island",
  "Cocos (Keeling) Islands",
  "Colombia",
  "Comoros",
  "Congo, the Democratic Republic of",
  "Congo",
  "Cook Islands",
  "Costa Rica",
  "Cote d'Ivoire",
  "Croatia",
  "Cuba",
  "Curaçao",
  "Cyprus",
  "Czechia",
  "Denmark",
  "Djibouti",
  "Dominica",
  "Dominican Republic",
  "Ecuador",
  "Egypt",
  "El Salvador",
  "Equatorial Guinea",
  "Eritrea",
  "Estonia",
  "Eswatini",
  "Ethiopia",
  "Falkland Islands (Malvinas)",
  "Faroe Islands",
  "Fiji",
  "Finland",
  "France",
  "French Guiana",
  "French Polynesia",
  "French Southern Territories",
  "Gabon",
  "Gambia",
  "Georgia",
  "Germany",
  "Ghana",
  "Gibraltar",
  "Greece",
  "Greenland",
  "Grenada",
  "Guadeloupe",
  "Guam",
  "Guatemala",
  "Guernsey",
  "Guinea",
  "Guinea-Bissau",
  "Guyana",
  "Haiti",
  "Heard Island and McDonald Islands",
  "Holy See (Vatican City State)",
  "Honduras",
  "Hong Kong",
  "Hungary",
  "Iceland",
  "India",
  "Indonesia",
  "Iran, Islamic Republic of",
  "Iraq",
  "Ireland",
  "Isle of Man",
  "Israel",
  "Italy",
  "Jamaica",
  "Japan",
  "Jersey",
  "Jordan",
  "Kazakhstan",
  "Kenya",
  "Kiribati",
  "Korea, Democratic People's Republic of",
  "Korea, Republic of",
  "Kuwait",
  "Kyrgyzstan",
  "Lao People's Democratic Republic",
  "Latvia",
  "Lebanon",
  "Lesotho",
  "Liberia",
  "Libya",
  "Liechtenstein",
  "Lithuania",
  "Luxembourg",
  "Macao",
  "Madagascar",
  "Malawi",
  "Malaysia",
  "Maldives",
  "Mali",
  "Malta",
  "Marshall Islands",
  "Martinique",
  "Mauritania",
  "Mauritius",
  "Mayotte",
  "Mexico",
  "Micronesia, Federated States of",
  "Moldova, Republic of",
  "Monaco",
  "Mongolia",
  "Montenegro",
  "Montserrat",
  "Morocco",
  "Mozambique",
  "Myanmar",
  "Namibia",
  "Nauru",
  "Nepal",
  "Netherlands",
  "New Caledonia",
  "New Zealand",
  "Nicaragua",
  "Niger",
  "Nigeria",
  "Niue",
  "Norfolk Island",
  "Northern Mariana Islands",
  "Norway",
  "Oman",
  "Pakistan",
  "Palau",
  "Palestine, State of",
  "Panama",
  "Papua New Guinea",
  "Paraguay",
  "Peru",
  "Philippines",
  "Pitcairn",
  "Poland",
  "Portugal",
  "Puerto Rico",
  "Qatar",
  "Republic of North Macedonia",
  "Romania",
  "Russian Federation",
  "Rwanda",
  "Reunion",
  "Saint Barthélemy",
  "Saint Helena, Ascension and Tristan da Cunha",
  "Saint Kitts and Nevis",
  "Saint Lucia",
  "Saint Martin (French part)",
  "Saint Pierre and Miquelon",
  "Saint Vincent and the Grenadines",
  "Samoa",
  "San Marino",
  "Sao Tome and Principe",
  "Saudi Arabia",
  "Senegal",
  "Serbia",
  "Seychelles",
  "Sierra Leone",
  "Singapore",
  "Sint Maarten (Dutch part)",
  "Slovakia",
  "Slovenia",
  "Solomon Islands",
  "Somalia",
  "South Africa",
  "South Georgia and the South Sandwich Islands",
  "South Sudan",
  "Spain",
  "Sri Lanka",
  "Sudan",
  "Suriname",
  "Svalbard and Jan Mayen",
  "Sweden",
  "Switzerland",
  "Syrian Arab Republic",
  "Taiwan (Province of China)",
  "Tajikistan",
  "Tanzania, United Republic of",
  "Thailand",
  "Timor-Leste",
  "Togo",
  "Tokelau",
  "Tonga",
  "Trinidad and Tobago",
  "Tunisia",
  "Turkey",
  "Turkmenistan",
  "Turks and Caicos Islands",
  "Tuvalu",
  "Uganda",
  "Ukraine",
  "United Arab Emirates",
  "United Kingdom of Great Britain and Northern Ireland",
  "United States Minor Outlying Islands",
  "United States of America",
  "Uruguay",
  "Uzbekistan",
  "Vanuatu",
  "Venezuela, Bolivarian Republic of",
  "Viet Nam",
  "Virgin Islands (British)",
  "Virgin Islands (U.S.)",
  "Wallis and Futuna",
  "Western Sahara",
  "Yemen",
  "Zambia",
  "Zimbabwe"
];

function addCountryOption(id) {
	var select = document.getElementById(id);
	if(select) {
		countryList.forEach(function(item) {
			var opt = document.createElement('option');
			opt.value = item;
    		opt.innerHTML = item;

			if(item == 'Italy') {
				opt.selected = true;
			}
				
			select.appendChild(opt);
		});
	}
}


const firstAidList = [
"A.O. A. CARDARELLI",
"A.O. DEI COLLI -P COTUGNO",
"A.O. DEI COLLI -P CTO",
"A.O. OO.RR. SANGIOVANNI DI DIO E RUGGI",
"A.O. RUMMO DI BENEVENTO",
"A.O. S.G. MOSCATI",
"A.O. SANT'ANNA E SAN SEBASTIANO CASERTA",
"A.O.U. FEDERICO II DI NAPOLI",
"AZIENDA UNIVERSITARIA POLICLINICO",
"CASA DI CURA OSPEDALE FATEBENEFRATELLI",
"CASA DI CURA PINETA GRANDE",
"CASA DI CURA VILLA DEI FIORI SRL",
"FONDAZIONE EVANGELICA BETANIA",
"OSP.CIV. GAETANINA SCOTTO",
"OSP. SACRO CUORE DI GESU` FATEBENEFRATELLI",
"OSPEDALE AMICO G. FUCITO",
"OSPEDALE ARIANO IRPINO",
"OSPEDALE CIVILE S. GIOVANNI DI DIO",
"OSPEDALE DI ROCCADASPIDE",
"OSPEDALE LANDOLFI SOLOFRA",
"OSPEDALE RIZZOLI",
"OSPEDALE S. ANGELO DEI LOMBARDI",
"OSPEDALE S. GIULIANO",
"OSPEDALE S. GIUSEPPE E MELORIO",
"OSPEDALE S. LEONARDO",
"OSPEDALE S. M. DELLE GRAZIE",
"OSPEDALE S. LUCA VALLO LUCANIA",
"OSPEDALE SANTOBONO",
"OSPEDALI RIUNITI AREA NOLANA PLESSO NOLA",
"P.O. BOSCOTRECASE",
"P.O. CAPILUPI CAPRI",
"P.O. DE LUCA E ROSSANO",
"P.O. DEI PELLEGRINI",
"P.O. DI AGROPOLI",
"P.O. DI POLLA -S. ARSENIO",
"P.O. IMMACOLATA SAPRI",
"P.O. ITALIA GIORDANO",
"P.O. LORETO MARE",
"P.O. MADDALONI",
"P.O. MARCIANISE",
"P.O. MARESCA",
"P.O. MARIA SS. ADDOLORATA EBOLI",
"P.O. MARTIRI DI VILLA MALTA SARNO",
"P.O. OSPEDALE DEL MARE",
"P.O. PIEDIMONTE MATESE",
"P.O. S. FRANCESCO DASSISI OLIVETO CITRA",
"P.O. S. G. MOSCATI AVERSA",
"P.O. S. M. DELL'OLMO",
"P.O. S. M. SPERANZA BATTIPAGLIA",
"P.O. S. MARIA DELLA MISERICORDIA",
"P.O. SAN GIOVANNI BOSCO",
"P.O. SAN PAOLO",
"P.O. SAN ROCCO",
"P.O. SANT' ALFONSO MARIA DEI LIGUORI",
"P.O. UMBERTO I NOCERA INFERIORE"
];

function addFirstAidOption(id) {
	var select = document.getElementById(id);
	if(select) {
		firstAidList.forEach(function(item) {
			var opt = document.createElement('option');
			opt.value = item;
    		opt.innerHTML = item;
			select.appendChild(opt);
		});
	}
}

function justification(text, maxLen) {
		var words = text.split(" ");
		words = fullJustifyLeft(words, maxLen);
		return words.join("\n");	
	}

	function fullJustifyLeft(words, maxLen) {
		  var lines = asLines(words, maxLen).map(x => justify(x, maxLen));
		  if(lines.length > 0) {
			  lines[lines.length-1] = lines[lines.length-1].replace(/\s+/g,' ');
		  }
		  return lines;
	}	
	
	function fullJustify(words, maxLen) {
		  return asLines(words, maxLen).map(x => justify(x, maxLen))
	}

	function asLines(words, maxLen, curLine=[], charCount = 0, lines = []) {

		  if (!words.length)
		    return lines.concat([curLine])

		  const nextWord        = words[0]
		  const remainingWords  = words.slice(1)
		  const additionalChars = nextWord.length + (curLine.length ? 1 : 0)
		  const nextCharCount   = charCount + additionalChars
		  const breakLine       = nextCharCount > maxLen

		  if (breakLine)
		    return asLines(words, maxLen, [], 0, lines.concat([curLine]))

		  return asLines( remainingWords, maxLen, curLine.concat(nextWord),
		    nextCharCount, lines )
		}

	function justify(words, len) {
		  if (words.length == 1)
		    return words[0] + ' '.repeat(len - words[0].length)

		  const numPaddedWords  = words.length - 1
		  const totalChars      = words.reduce((m, w) => m + w.length, 0)
		  const extraChars      = len - totalChars
		  const spaceBetween    = Math.floor(extraChars / numPaddedWords)
		  const spacer          = ' '.repeat(spaceBetween)
		  const extraSpaces     = extraChars - spaceBetween * numPaddedWords
		  const leftPaddedWords = words.slice(1).map(
		    (w, i) => spacer + (i < extraSpaces ? ' ' : '') + w
		  )
		  return [words[0], ...leftPaddedWords].join('')
	}


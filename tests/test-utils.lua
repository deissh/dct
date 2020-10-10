#!/usr/bin/lua

require("dcttestlibs")
require("dct")
local utils = require("dct.utils")
local json  = require("libs.json")

local deg = '°'
local testll = {
	[1] = {
		["lat"]  = 88.123,
		["long"] = -63.456,
		["precision"] = 0,
		["format"] = utils.posfmt.DD,
		["expected"] = "088"..deg.."N 063"..deg.."W",
	},
	[2] = {
		["lat"]  = 88.123,
		["long"] = -63.456,
		["precision"] = 3,
		["format"] = utils.posfmt.DDM,
		["expected"] = "88"..deg.."07.38'N 063"..deg.."27.36'W",
	},
	[3] = {
		["lat"]  = 88.123,
		["long"] = -63.456,
		["precision"] = 5,
		["format"] = utils.posfmt.DMS,
		["expected"] = "88"..deg.."07'22.800\"N 063"..deg.."27'21.600\"W",
	},
}

local testmgrs = {
	[1] = {
		["mgrs"] = {
			["UTMZone"] = "DD",
			["MGRSDigraph"] = "GJ",
			["Easting"] = 01234,
			["Northing"] = 56789,
		},
		["precision"] = 0,
		["expected"] = "DD GJ",
	},
	[2] = {
		["mgrs"] = {
			["UTMZone"] = "DD",
			["MGRSDigraph"] = "GJ",
			["Easting"] = 01234,
			["Northing"] = 56789,
		},
		["precision"] = 3,
		["expected"] = "DD GJ012567",
	},
}

local testlo = {
	[1] = {
		["position"] = {
			["x"] = 100.2,
			["y"] = 20,
			["z"] = -50.35,
		},
		["precision"] = 3,
		["format"] = utils.posfmt.MGRS,
		["expected"] = "DD GJ012567",
	},
	[2] = {
		["position"] = {
			["x"] = 100.2,
			["y"] = 20,
			["z"] = -50.35,
		},
		["precision"] = 5,
		["format"] = utils.posfmt.DMS,
		["expected"] = "88"..deg.."07'22.800\"N 063"..deg.."27'21.600\"W",
	},
}

local testcentroid = {
	[1] = {
		["points"] = {
			[1] = {
				["x"] = 10, ["y"] = -4, ["z"] = 15,
			},
			[2] = {
				["x"] = 5, ["z"] = 2,
			},
			[3] = {
				["y"] = 7, ["z"] = 4,
			},
		},
		["expected"] = {
			["x"] = 5, ["y"] = 1, ["z"] = 7,
		},
	},
	[2] = {
		["points"] = {
			[1] = {
				["x"] = 10, ["z"] = 15,
			},
			[2] = {
				["x"] = 4, ["z"] = 2,
			},
			[3] = {
				["x"] = 7, ["z"] = 4,
			},
		},
		["expected"] = {
			["x"] = 7, ["y"] = 0, ["z"] = 7,
		},
	},

}

local function main()
	for _, v in ipairs(testll) do
		local str = utils.LLtostring(v.lat, v.long, v.precision, v.format)
		assert(str == v.expected,
			"utils.LLtostring() unexpected value; got: '"..str..
			"'; expected: '"..v.expected.."'")
	end
	for _, v in ipairs(testmgrs) do
		local str = utils.MGRStostring(v.mgrs, v.precision)
		assert(str == v.expected,
			"utils.MGRStostring() unexpected value; got: '"..str..
			"'; expected: '"..v.expected.."'")
	end
	for _, v in ipairs(testlo) do
		local str = utils.fmtposition(v.position, v.precision, v.format)
		assert(str == v.expected,
			"utils.fmtposition unexpected value; got: '"..str..
			"'; expected: '"..v.expected.."'")
	end
	for _, v in ipairs(testcentroid) do
		local centroid, n
		for _, pt in ipairs(v.points) do
			centroid, n = utils.centroid(pt, centroid, n)
		end
		assert(centroid.x == v.expected.x and centroid.y == v.expected.y and
			centroid.z == v.expected.z,
			"utils.centroid unexpected value; got: "..
			json:encode_pretty(centroid).."; expected: "..
			json:encode_pretty(v.expected))
	end

	assert("2001-06-22 16:00l" == utils.date("%F %Rl", utils.time(3600)),
		"failed: "..utils.date("%F %Rl", utils.time(3600)))
	assert("2001-06-22 10:00z" == utils.date("%F %Rz", utils.zulutime(3600)),
		"failed: "..utils.date("%F %Rz", utils.zulutime(3600)))
	return 0
end

os.exit(main())

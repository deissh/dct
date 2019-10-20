--[[
-- SPDX-License-Identifier: LGPL-3.0
--
-- Provides functions for handling templates.
--]]

local assetType = {
	-- control zones
	["KEEPOUT"]     = 1,

	-- strategic types
	["AMMODUMP"]    = 2,
	["FUELDUMP"]    = 3,
	["C2"]          = 4,
	["EWR"]         = 5,
	["MISSILE"]     = 6,
	["OCA"]         = 7,
	["PORT"]        = 8,
	["SAM"]         = 9,
	["FACILITY"]    = 10,

	-- bases
	["BASEDEFENSE"] = 11,

	-- tactical
	["JTAC"]        = 12,
	["LOGISTICS"]   = 13,
	["SEA"]         = 14,

	-- extended type set
	["BUNKER"]      = 15,
	["CHECKPOINT"]  = 16,
	["FACTORY"]     = 17,
}

local missionType = {
	["CAS"]      = 1,
	["CAP"]      = 2,
	["STRIKE"]   = 3,
	["SEAD"]     = 4,
	["BAI"]      = 5,
	["OCA"]      = 6,
}

local assetClass = {
	["STRATEGIC"] = {
		[assetType.AMMODUMP]    = true,
		[assetType.FUELDUMP]    = true,
		[assetType.C2]          = true,
		[assetType.EWR]         = true,
		[assetType.MISSILE]     = true,
		[assetType.OCA]         = true,
		[assetType.PORT]        = true,
		[assetType.SAM]         = true,
		[assetType.FACILITY]    = true,
		[assetType.BUNKER]      = true,
		[assetType.CHECKPOINT]  = true,
		[assetType.FACTORY]     = true,
	},
}

local missionTypeMap = {
	[missionType.STRIKE] = {
		[assetType.AMMODUMP]   = true,
		[assetType.FUELDUMP]   = true,
		[assetType.C2]         = true,
		[assetType.MISSILE]    = true,
		[assetType.PORT]       = true,
		[assetType.FACILITY]   = true,
		[assetType.BUNKER]     = true,
		[assetType.CHECKPOINT] = true,
		[assetType.FACTORY]    = true,
	},
	[missionType.SEAD] = {
		[assetType.EWR]      = true,
		[assetType.SAM]      = true,
	},
	[missionType.OCA] = {
		[assetType.OCA]         = true,
		[assetType.BASEDEFENSE] = true,
	},
	[missionType.BAI] = {
		[assetType.LOGISTICS] = true,
		[assetType.SEA]       = true,
	},
	[missionType.CAS] = {
		[assetType.JTAC] = true,
	},
}

local enum = {
	["assetType"] = assetType,
	["assetClass"] = assetClass,
	["missionType"] = missionType,
	["missionTypeMap"] = missionTypeMap,
}

return enum
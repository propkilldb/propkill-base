/*
Rounds
*/

Round = {}
Round.__index = Round

function Round:Create()
	local round = {}
	setmetatable(round, Round)
	round.timeRemaining = 0
	round.length = 600
	round.id = "PK_Round_Generic"
	round.players = {}
	round.active = false
	return round
end

function Round:Start()
	timer.Create(self.id, self.length, 1, self.End)
	self.timeRemaining = self.length
	self.active = true
end

function Round:End()
	self.timeRemaining = 0
	self.active = false
end

function StartWarmup()
	timer.Create("pk_warmuptimer", 30, 1, EndWarmup)
end

function EndWarmup()

end

hook.Add("Initialize", "pk_startroundtimers", asd)

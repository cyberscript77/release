--[[
	
	MADE BY HASNAIN RAZA
	
	LVector2 is a simple two dimensional vector mathematics class.
	
	DEMO (all features)
	
	local a, b, c = LVector2.new(1, 1), LVector2.new(2, 2), LVector2.new(3, 3)
	
	print(a + b)
	print(a:addVectors(b))
	print(LVector2.addVectors(a, b))
	
	print(a - b)
	print(a:subtractVectors(b))
	print(LVector2.subtractVectors(a, b))
		
	print(a * b)
	print(a:multiplyVectors(b))
	print(LVector2.multiplyVectors(a, b))
		
	print(a / b)
	print(a:divideVectors(b))
	print(LVector2.divideVectors(a, b))
	
	print(-c)
	
	print(a + 1)
	print(a:addScalar(1))
	print(LVector2.addScalar(a, b))
	
	print(a - 1)
	print(a:subtractScalar(1))
	print(LVector2.subtractScalar(a, b))
	
	print(a * 1)
	print(a:multiplyScalar(1))
	print(LVector2.multiplyScalar(a, b))
	
	print(a / 1)
	print(a:multiplyScalar(1))
	print(LVector2.multiplyScalar(a, b))
	
	print(c.magnitude)
	print(c:getMagnitude())
	print(LVector2.getMagnitude(c))
	
	print(c.unit)
	print(c:getUnitVector())
	print(LVector2.getUnitVector(c))
	
	print(a == b)
	print(a:equals(b, 0.01))
	print(LVector2.equals(a, b, 0.01))
	
	print(
		c:mapVector(function(x, y)
			return (x + y), (x - y)
		end)
	)
	
	It is recommended that you rely on arithmetic operators rather than calling functions
	because error handling is done primarily on the operators.
	
--]]


local LVector2 = {}

--// METAMETHODS //--

local function umn(self)
	return (self * -1)
end

local function add(self, value)
	if (type(value) == "number") then
		return LVector2.addScalar(self, value)
	elseif (type(value) == "table") then
		if (value.className) and (value.className == "LVector2") then
			return LVector2.addVectors(self, value)
		else
			error("attempt to perform arithmetic (add) on " .. self.className .. " and unknown")
		end
	else
		error("attempt to perform arithmetic (add) on " .. self.className .. " and " .. type(value))
	end
end

local function sub(self, value)
	if (type(value) == "number") then
		return LVector2.subtractScalar(self, value)
	elseif (type(value) == "table") then
		if (value.className) and (value.className == "LVector2") then
			return LVector2.subtractVectors(self, value)
		else
			error("attempt to perform arithmetic (subtract) on " .. self.className .. " and unknown")
		end
	else
		error("attempt to perform arithmetic (subtract) on " .. self.className .. " and " .. type(value))
	end
end

local function mul(self, value)
	if (type(value) == "number") then
		return LVector2.multiplyScalar(self, value)
	elseif (type(value) == "table") then
		if (value.className) and (value.className == "LVector2") then
			return LVector2.multiplyVectors(self, value)
		else
			error("attempt to perform arithmetic (multiply) on " .. self.className .. " and unknown")
		end
	else
		error("attempt to perform arithmetic (multiply) on " .. self.className .. " and " .. type(value))
	end
end

local function div(self, value)
	if (type(value) == "number") then
		return LVector2.divideScalar(self, value)
	elseif (type(value) == "table") then
		if (value.className) and (value.className == "LVector2") then
			return LVector2.divideVectors(self, value)
		else
			error("attempt to perform arithmetic (divide) on " .. self.className .. " and unknown")
		end
	else
		error("attempt to perform arithmetic (divide) on " .. self.className .. " and " .. type(value))
	end
end

local function tostringMetamethod(self)
	return ("( " .. self.x .. ", " .. self.y .. ")")
end

local function eq(self, value)
	return LVector2.equals(self, value, 0.01)
end

--// CONSTRUCTOR //--

function LVector2.new(x, y)

	-- Handles Input --
	if (x) and (type(x) ~= "number") then error("number expected, got " .. type(x)) end
	if (y) and (type(y) ~= "number") then error("number expected, got " .. type(y)) end
	----
	
	local dataTable = setmetatable(
		{
			x = x or 0,
			y = y or 0,
			className = "LVector2"
		},
		LVector2
	)
	
	local proxyTable = setmetatable(
		{
			
		},
		{
			__index = function(self, index)
				if (index == "magnitude") then
					return LVector2.getMagnitude(self)
				elseif (index == "unit") then
					return LVector2.getUnitVector(self)
				else
					return (dataTable[index])
				end
			end,
			
			__newindex = function(self, index, newValue)
				if (index == "x") or (index == "y") then
					if (newValue) and (type(newValue) ~= "number") then
						error("number expected, got " .. type(index))
					else
						dataTable[index] = newValue
					end
				else
					error(newValue .. " cannot be assigned")
				end
			end,
			
			__unm = umn,
			__add = add,
			__sub = sub,
			__mul = mul,
			__div = div,
			__eq = eq,
			__tostring = tostringMetamethod
		}
	)
	
	return proxyTable
	
end

--// METHODS //--

function LVector2.addVectors(firstLVector2, secondLVector2)
	return LVector2.new(firstLVector2.x + secondLVector2.x, firstLVector2.y + secondLVector2.y)
end

function LVector2.subtractVectors(firstLVector2, secondLVector2)
	return LVector2.new(firstLVector2.x - secondLVector2.x, firstLVector2.y - secondLVector2.y)
end

function LVector2.multiplyVectors(firstLVector2, secondLVector2)
	return LVector2.new(firstLVector2.x * secondLVector2.x, firstLVector2.y * secondLVector2.y)
end

function LVector2.divideVectors(firstLVector2, secondLVector2)
	return LVector2.new(firstLVector2.x / secondLVector2.x, firstLVector2.y / secondLVector2.y)
end

function LVector2.addScalar(LVector2, scalar)
	return LVector2.new(LVector2.x + scalar, LVector2.y + scalar)
end

function LVector2.subtractScalar(LVector2, scalar)
	return LVector2.new(LVector2.x - scalar, LVector2.y - scalar)
end

function LVector2.multiplyScalar(LVector2, scalar)
	return LVector2.new(LVector2.x * scalar, LVector2.y * scalar)
end

function LVector2.divideScalar(LVector2, scalar)
	return LVector2.new(LVector2.x / scalar, LVector2.y / scalar)
end

function LVector2.mapVector(LVector2, mapFunction)
	local x, y = mapFunction(LVector2.x, LVector2.y)
	return LVector2.new(x, y)
end

function LVector2.equals(firstLVector2, secondLVector2, epsilon)
	return ((firstLVector2 - secondLVector2).magnitude < epsilon)
end

function LVector2.getMagnitude(LVector2)
	return math.sqrt(
		LVector2.x^2 +
		LVector2.y^2
	)
end

function LVector2.getUnitVector(LVector2)
	return (LVector2/LVector2.magnitude)
end

--// INSTRUCTIONS //--

LVector2.__index = LVector2

return LVector2

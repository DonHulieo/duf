--------------------------------- Compare Tables ---------------------------------

---@param t1 table
---@param t2 table
---@return boolean
local function CompareTables(t1, t2)
    if #t1 ~= #t2 then return false end
    for k, v in pairs(t1) do
        if t2[k] ~= v then return false end
    end
    return true
end

exports('CompareTables', function(t1, t2) return CompareTables(t1, t2) end)

--------------------------------- Sort Table ---------------------------------

---@param t table
---@param sortFunc function
---@return table
local function SortTable(t, sortFunc)
    for i = 1, #t do
        for j = 1, #t do
            if sortFunc(t[i], t[j]) then
                t[i], t[j] = t[j], t[i]
            end
        end
    end
    return t
end

exports('SortTable', function(t, sortFunc) return SortTable(t, sortFunc) end)

--------------------------------- Round Number ---------------------------------

---@param num number
---@param numDecimalPlaces number
---@return number
local function RoundNumber(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces > 0 then
        local mult = 10^numDecimalPlaces
        return math.floor(num * mult + 0.5) / mult
    end
    
    return math.floor(num + 0.5)
end

exports('RoundNumber', function(num, numDecimalPlaces) return RoundNumber(num, numDecimalPlaces) end)

--------------------------------- Get Random Number ---------------------------------

---@param min number
---@param max number
---@return number
local function GetRandomNumber(min, max)
    return math.random() * (max - min) + min
end

exports('GetRandomNumber', function(min, max) return GetRandomNumber(min, max) end)

--------------------------------- Converting Tables to Vectors --------------------------------- [Credits go to: Swkeep | https://github.com/swkeep]

---@param table table
---@return 'vector2'
local function ConvertToVec2(table)
    return vector2(table.x, table.y)
end

---@param table table
---@return 'vector3'
local function ConvertToVec3(table)
    return vector3(table.x, table.y, table.z)
end

---@param table table
---@return 'vector4'
local function ConvertToVec4(table)
    return vector4(table.x, table.y, table.z, table.w)
end

exports('ConvertToVec2', function(table) return ConvertToVec2(table) end)
exports('ConvertToVec3', function(table) return ConvertToVec3(table) end)
exports('ConvertToVec4', function(table) return ConvertToVec4(table) end)

--------------------------------- Get Distance Between Coords ---------------------------------

---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@return number
local function GetDistVec2(x1, y1, x2, y2)
    local from, to = nil, nil
    if type(x1) == 'table' and type(y1) == 'table' then
        from = ConvertToVec2(x1)
        to = ConvertToVec2(y1)
    elseif type(x1) == 'vector2' and type(y1) == 'vector2' then
        from = x1
        to = y1
    else
        from = vector2(x1, y1)
        to = vector2(x2, y2)
    end
    return #(from - to)
end

---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@return number
local function GetDistVec3(x1, y1, z1, x2, y2, z2)
    local from, to = nil, nil
    if type(x1) == 'table' and type(y1) == 'table' then
        from = ConvertToVec3(x1)
        to = ConvertToVec3(y1)
    elseif type(x1) == 'vector3' and type(y1) == 'vector3' then
        from = x1
        to = y1
    else
        from = vector3(x1, y1, z1)
        to = vector3(x2, y2, z2)
    end
    return #(from - to)
end

exports('GetDistVec2', function(x1, y1, x2, y2) return GetDistVec2(x1, y1, x2, y2) end)
exports('GetDistVec3', function(x1, y1, z1, x2, y2, z2) return GetDistVec3(x1, y1, z1, x2, y2, z2) end)

--------------------------------- Get Heading Between Coords ---------------------------------

---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@return number
local function GetHeadingBetweenCoords(x1, y1, z1, x2, y2, z2)
    local from, to = nil, nil
    if type(x1) == 'table' and type(y1) == 'table' then
        from = ConvertToVec3(x1)
        to = ConvertToVec3(y1)
    elseif type(x1) == 'vector3' and type(y1) == 'vector3' then
        from = x1
        to = y1
    else
        from = vector3(x1, y1, z1)
        to = vector3(x2, y2, z2)
    end
    local dx = to.x - from.x
    local dy = to.y - from.y
    local heading = math.deg(math.atan2(dy, dx))
    if heading < 0 then heading = heading + 360 end
    return heading
end

exports('GetHeadingBetweenCoords', function(x1, y1, z1, x2, y2, z2) return GetHeadingBetweenCoords(x1, y1, z1, x2, y2, z2) end)

--------------------------------- Get Distance Between Points ---------------------------------

---@param point1 'vector3' | 'vector2' | table
---@param point2 'vector3' | 'vector2' | table
---@return number
local function GetDistBetweenPoints(point1, point2)
    local x1, y1, z1, x2, y2, z2 = nil, nil, nil, nil, nil, nil
    if type(point1) == 'table' then
        x1 = point1.x
        y1 = point1.y
        z1 = point1.z
    elseif type(point1) == 'vector2' then
        x1 = point1.x
        y1 = point1.y
    elseif type(point1) == 'vector3' then
        x1 = point1.x
        y1 = point1.y
        z1 = point1.z
    end
    if type(point2) == 'table' then
        x2 = point2.x
        y2 = point2.y
        z2 = point2.z
    elseif type(point2) == 'vector2' then
        x2 = point2.x
        y2 = point2.y
    elseif type(point2) == 'vector3' then
        x2 = point2.x
        y2 = point2.y
        z2 = point2.z
    end
    if z1 and z2 then
        return GetDistVec3(x1, y1, z1, x2, y2, z2)
    else
        return GetDistVec2(x1, y1, x2, y2)
    end
end

exports('GetDistBetweenPoints', function(point1, point2) return GetDistBetweenPoints(point1, point2) end)

--------------------------------- Get Angle ---------------------------------

local function GetAngle(p)
    local angle = math.atan2(p.y - center.y, p.x - center.x)
    if angle < 0 then
        angle = angle + math.pi * 2
    end
    return angle
end

exports('GetAngle', function(p) return GetAngle(p) end)

--------------------------------- Get Angle Between Points ---------------------------------

---@param point1 'vector3' | 'vector2' | table
---@param point2 'vector3' | 'vector2' | table
---@return number
local function GetAngleBetweenPoints(point1, point2)
    local x1, y1, z1, x2, y2, z2 = nil, nil, nil, nil, nil, nil
    if type(point1) == 'table' then
        x1 = point1.x
        y1 = point1.y
        z1 = point1.z
    elseif type(point1) == 'vector2' then
        x1 = point1.x
        y1 = point1.y
    elseif type(point1) == 'vector3' then
        x1 = point1.x
        y1 = point1.y
        z1 = point1.z
    end
    if type(point2) == 'table' then
        x2 = point2.x
        y2 = point2.y
        z2 = point2.z
    elseif type(point2) == 'vector2' then
        x2 = point2.x
        y2 = point2.y
    elseif type(point2) == 'vector3' then
        x2 = point2.x
        y2 = point2.y
        z2 = point2.z
    end
    if z1 and z2 then
        return GetAngle(vector3(x1, y1, z1), vector3(x2, y2, z2))
    else
        return GetAngle(vector2(x1, y1), vector2(x2, y2))
    end
end

exports('GetAngleBetweenPoints', function(point1, point2) return GetAngleBetweenPoints(point1, point2) end)

--------------------------------- Calculate Incline ---------------------------------

---@param entity number | Entity Handle 
---@param ms number | Milliseconds to calculate incline over
---@return number | Incline in degrees
local function CalculateIncline(entity, ms)
    local entity = entity
    local ms = ms or 1000
    local startZ = GetEntityCoords(entity).z
    Wait(ms)
    local endZ = GetEntityCoords(entity).z
    local dist = endZ - startZ
    local incline = math.deg(math.atan2(dist, ms / 1000))
    return incline
end

exports('CalculateIncline', function(entity, ms) return CalculateIncline(entity, ms) end)

--------------------------------- Order Vectors By ---------------------------------

---@param table table | An Array of Vectors to Order
---@param key string | The Key to Order By, (x, y, z)
---@param order string | The Order to Order By, (asc, desc, clkws, cnt-clkws)
---@return table
local function OrderVectorsBy(table, key, order)
    local function asc(a, b) return a[key] < b[key] end
    local function desc(a, b) return a[key] > b[key] end
    local function clkws(a, b) return math.atan2(a.y, a.x) < math.atan2(b.y, b.x) end
    local function cnt_clkws(a, b) return math.atan2(a.y, a.x) > math.atan2(b.y, b.x) end
    if order == 'asc' then
        SortTable(table, asc)
    elseif order == 'desc' then
        SortTable(table, desc)
    elseif order == 'clkws' then
        SortTable(table, clkws)
    elseif order == 'cnt-clkws' then
        SortTable(table, cnt_clkws)
    end
    return table
end

exports('OrderVectorsBy', function(table, key, order) return OrderVectorsBy(table, key, order) end)

--------------------------------- Is Point Within Polygon ---------------------------------

---@param point 'vector3' | 'vector2' | table
---@param polygon table
---@return boolean
local function IsPointInPoly(point, polygon)
    local x, y = nil, nil
    if type(point) == 'table' then
        x = point.x
        y = point.y
    elseif type(point) == 'vector2' then
        x = point.x
        y = point.y
    elseif type(point) == 'vector3' then
        x = point.x
        y = point.y
    end
    local inside = false
    local j = #polygon
    for i = 1, #polygon do
        if ((polygon[i].y > y) ~= (polygon[j].y > y)) and (x < (polygon[j].x - polygon[i].x) * (y - polygon[i].y) / (polygon[j].y - polygon[i].y) + polygon[i].x) then
            inside = not inside
        end
        j = i
    end
    return inside
end

exports('IsPointInPoly', function(point, polygon) return IsPointInPoly(point, polygon) end)
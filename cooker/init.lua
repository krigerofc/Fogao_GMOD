AddCSLuaFile('shared.lua')
AddCSLuaFile('cl_init.lua')

include('shared.lua')

function ENT:Initialize()
    self:SetModel("models/props_c17/furnitureStove001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self.timer = CurTime()

    local phy = self:GetPhysicsObject()

    if phy:IsValid() then
        phy:Wake()
    end

    self.isBaking = false
    self.time_fim = 0
end


function ENT:StartTouch(ent)
    print(ent:GetClass())
    if ent:GetClass() == 'melao' and self.isBaking == false then
        self.isBaking = true
        ent:Remove()
        self.time_fim = CurTime() + 5
    end


end


function ENT:Think()
    if self.isBaking == true then
        self:Ignite(1, 1)
        self:SetColor(Color(255, 0, 0))
    else
        self:SetColor(Color(0, 255,0))
    end

    if self.isBaking == true then
        if self.time_fim <= CurTime() then 
            self.isBaking = false

            local leite = ents.Create('Milk')
            leite:SetPos(self:GetPos() + Vector(0, 25, 0))
            leite:Spawn()
        end
    end
end
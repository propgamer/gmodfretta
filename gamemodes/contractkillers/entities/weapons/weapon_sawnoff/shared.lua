//General Variables\\
SWEP.DrawCrosshair = true
SWEP.Weight = 5
SWEP.ViewModel = "models/weapons/v_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 64
SWEP.Slot = 2

SWEP.AutoSwitchTo = true

SWEP.FiresUnderwater = true
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ReloadSound = "Weapon_Pistol.Reload"
SWEP.SlotPos = 0
SWEP.Instructions = "Only useful at close range"
SWEP.AutoSwitchFrom = false
SWEP.base = "weapon_base"
SWEP.Category = "shotgun"
SWEP.DrawAmmo = true
SWEP.PrintName = "sawnoff shotgun"
//General Variables\\

//Primary Fire Variables\\
SWEP.Primary.NumberofShots = 9
SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.Spread = 1.4
SWEP.Primary.ClipSize = 2
SWEP.Primary.Force = 40
SWEP.Primary.Damage = 16
SWEP.Primary.Delay = 1
SWEP.Primary.Recoil = 1.2
SWEP.Primary.DefaultClip = 12
SWEP.Primary.Automatic = false
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Sound = "Weapon_Shotgun.Double"
//Primary Fire Variables\\

//Secondary Fire Variables\\
SWEP.Secondary.ClipSize = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.NumberofShots = 1
SWEP.Secondary.Damage = 10
SWEP.Secondary.Ammo = "Pistol"
SWEP.Secondary.Spread = 0.1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Force = 10
SWEP.Secondary.Recoil = 1
SWEP.Secondary.Sound = "Weapon_Pistol.Single"
SWEP.Secondary.TakeAmmo = 1
SWEP.Secondary.Delay = 0.2
//Secondary Fire Variables\\

//SWEP:Initialize()\\
function SWEP:Initialize()
	util.PrecacheSound(self.Primary.Sound)
	util.PrecacheSound(self.Secondary.Sound)
	self:SetWeaponHoldType( self.HoldType )
end
//SWEP:Initialize()\\

//SWEP:PrimaryFire()\\
function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	local bullet = {}
		bullet.Num = self.Primary.NumberofShots
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer	= 1									// Show a tracer on every x bullets 
		bullet.TracerName = "Tracer"
		bullet.Force = self.Primary.Force
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo
	local rnda = self.Primary.Recoil * -1
	local rndb = self.Primary.Recoil * math.random(-1, 1)
	self:ShootEffects()
	self.Owner:FireBullets( bullet )
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
end
//SWEP:PrimaryFire()\\

//SWEP:SecondaryFire()\\
function SWEP:SecondaryFire()
	return false
end
//SWEP:SecondaryFire()\\


return {
  legohelios = {
    name = 'legohelios',
    Description = 'Celestial Earth Scorcher',
    objectName = 'dbg_sphere_fullmetal.s3o',
    script = 'Units/ARMSILO.cob',
    buildPic = 'ARMSPID.DDS',
    -- Costs
    metalCost = 110000,
    energyCost = 1500000,
    buildTime = 1100000,
    -- Stats
    health = 100000,
    speed = 50,
    sightDistance = 1500,
    airSightDistance = 1500,
    radarDistance = 0,
    -- Movement
    maxAcc = 0.5,
    maxDec = 0.5,
    reclaimable = false,
    repairable = true,
    canMove = true,
    canFly = true,
    cruiseAltitude = 1850,
    hoverAttack = true,
    airHoverFactor = 0,
    verticalSpeed = 8,
    category = 'SPACENOTOBJECT',
    useSmoothMesh = true,
    turnInPlace = true,
    -- Combat
    radiusAdjust = 3,
    turnRate = 160,
    upright = true,
    airStrafe = false,
    selfDestructAs = 'ScavComBossExplo',
    explodeAs = 'korgExplosion',
    collisionVolumeType = 'sphere',
    -- Custom params
    customParams = {
      techlevel = 3,
      i18n_en_humanname = 'Phaethon',
      i18n_en_tooltip = 'Celestial Earth Scorcher',
      unitgroup = 'weapon',
      enabled_on_no_sea_maps = true,
      ignore_noair = true
    },
    -- Icon
    iconType = 'defence_hllllt'
  }
}

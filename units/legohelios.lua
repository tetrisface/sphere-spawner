return {
  legohelios = {
    -- Basic properties
    name = 'legohelios',
    description = 'Celestial Earth Scorcher',
    objectname = 'dbg_sphere_fullmetal.s3o',
    buildpic = 'ARMSPID.DDS',
    script = "Units/ARMSILO.cob",

    -- Costs
    metalcost = 110000,
    energycost = 1500000,
    buildtime = 1100000,

    -- eco
    energystorage = 1000000,
    metalstorage = 1000000,
    energymake = 1000000,
    metalmake = 1000000,

    -- Stats
    health = 100000,
    speed = 50,
    sightdistance = 1500,
    airsightdistance = 1500,
    radardistance = 0,

    -- Movement
    maxacc = 0.5,
    maxdec = 0.5,
    reclaimable = false,
    repairable = true,
    canmove = true,
    canfly = true,
    cruisealtitude = 1850,
    hoverattack = true,
    airhoverfactor = 0,
    verticalspeed = 8,
    category = 'SPACENOTOBJECT',
    usesmoothmesh = true,
    turninplace = true,

    -- Combat
    radiusadjust = 3,
    turnrate = 160,
    upright = true,
    airstrafe = false,
    selfdestructas = 'ScavComBossExplo',
    explodeas = 'korgExplosion',
    collisionvolumetype = 'sphere',

    -- Required fields that the engine expects
    footprintx = 2,
    footprintz = 2,
    idleautoheal = 5,
    idletime = 1800,
    maxslope = 10,
    maxwaterdepth = 12,
    movementclass = 'TANK3',
    nochasecategory = 'VTOL',
    seismicsignature = 0,
    trackoffset = 14,
    trackstrength = 5,
    tracktype = 'corwidetracks',
    trackwidth = 28,
    turninplaceanglelimit = 90,
    turninplacespeedlimit = 1.96,

    -- Custom params (lowercase as expected by engine)
    customparams = {
      techlevel = 3,
      i18n_en_humanname = 'Phaethon',
      i18n_en_tooltip = 'Celestial Earth Scorcher',
      unitgroup = 'weapon',
      enabled_on_no_sea_maps = true,
      ignore_noair = true,
      model_author = "ZephyrSkies",
      normaltex = "unittextures/leg_normal.dds",
      subfolder = "CorVehicles",
      aimfromweapon = 1,
      weapon1 = 1,
    },

    -- Required featuredefs
    featuredefs = {
      dead = {
        blocking = true,
        category = "corpses",
        collisionvolumeoffsets = "0 -4 1",
        collisionvolumescales = "30 12 28",
        collisionvolumetype = "Box",
        damage = 550,
        energy = 0,
        featuredead = "HEAP",
        featurereclamate = "SMUDGE01",
        footprintx = 2,
        footprintz = 2,
        height = 20,
        hitdensity = 100,
        metal = 105,
        object = "Units/dbg_sphere_fullmetal_dead.s3o",
        reclaimable = true,
        seqnamereclamate = "TREE1RECLAMATE",
        world = "All Worlds",
      },
      heap = {
        blocking = false,
        category = "heaps",
        collisionvolumescales = "35.0 4.0 6.0",
        collisionvolumetype = "cylY",
        damage = 225,
        energy = 0,
        featurereclamate = "SMUDGE01",
        footprintx = 2,
        footprintz = 2,
        height = 4,
        hitdensity = 100,
        metal = 45,
        object = "units/cor2x2f.s3o",
        reclaimable = true,
        resurrectable = 0,
        seqnamereclamate = "TREE1RECLAMATE",
        world = "All Worlds",
      },
    },

    -- Required sfxtypes
    sfxtypes = {
      pieceexplosiongenerators = {
        [1] = "deathceg2",
        [2] = "deathceg3",
      },
    },

    -- Required sounds
    sounds = {
      canceldestruct = "cancel2",
      underattack = "warning1",
      cant = {
        [1] = "cantdo4",
      },
      count = {
        [1] = "count6",
        [2] = "count5",
        [3] = "count4",
        [4] = "count3",
        [5] = "count2",
        [6] = "count1",
      },
      ok = {
        [1] = "tcormove",
      },
      select = {
        [1] = "tcorsel",
      },
    },

    -- Required weapondefs
    weapondefs = {
      t3heatray = {
        areaofeffect = 800,
        avoidfeature = false,
        avoidfriendly = false,
        alwaysvisible = true,
        beamtime = 5,
        camerashake = 0.1,
        corethickness = 5,
        craterareaofeffect = 100,
        craterboost = 0,
        cratermult = 0,
        canattackground = true,
        cylindertargeting = 50,
        edgeeffectiveness = 0.45,
        energypershot = 0,
        explosiongenerator = 'custom:heatray-huge',
        firestarter = 90,
        impulsefactor = 0,
        laserflaresize = 10,
        minIntensity = 1,
        name = 'Perfect Orbital Heatray',
        noselfdamage = true,
        proximitypriority = 1,
        range = 500,
        reloadtime = 15,
        rgbcolor = '1 0.5 0',
        rgbcolor2 = '0.9 1.0 0.5',
        soundhitdry = '',
        soundhitwet = 'sizzle',
        soundstart = 'heatray3',
        soundstartvolume = 38,
        soundtrigger = 1,
        thickness = 10,
        turret = true,
        tolerance = 65536,
        weapontype = 'BeamLaser',
        weaponvelocity = 2100,
        heightmod = 0.1,
        damage = {
          default = 50000
        }
      }
    },
    weapons = {
      [1] = {
        def = 't3heatray',
        maindir = '0 -1 0',
        maxangledif = 360,
        onlytargetcategory = 'SURFACE',
        badtargetcategory = 'VTOL',
        weaponmaindir = '0 -1 0',
        weaponmaindir2 = '0 0 1'
      }
    },

    -- Icon
    icontype = 'defence_hllllt'
  }
}

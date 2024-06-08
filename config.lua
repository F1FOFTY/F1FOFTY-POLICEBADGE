Config = Config or {}

Config.AllowedJobs = {'police', 'bcso', 'sast', 'fib'}  -- List of allowed jobs
Config.MaxDistance = 5.0  -- Maximum distance to flash the badge
Config.Messages = {
    NoBadge = "You don't have a badge.",  -- Message when the player doesn't have a badge
    NoOneNearby = "There's no one nearby to show your badge to.",  -- Message when no one is nearby
    BadgeFlashed = "%s has shown you their badge: %s",  -- Message when the badge is flashed
    StolenBadge = "You are using a stolen badge!"  -- Message when using a stolen badge
}

Config.BadgeItem = "police_badge"  -- Name of the badge item
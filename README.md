# F1FOFTY-POLICEBADGE

This script allows players on a QB-Core-based FiveM server to flash a police badge to other players. The badge display includes the player's name, badge number, picture, rank, and department. Players can also use a UI to change their rank, department, and update their personal information.

## Installation

1. **Download the Files:**
   Download the `F1FOFTY-POLICEBADGE` folder and place it in your server's `resources` directory.

2. **Add the Resource:**
   Add `ensure F1FOFTY-POLICEBADGE` to your server's `server.cfg` to ensure the resource starts with your server.

3. **Item Configuration:**
   Add the badge item to your `qb-core/shared/items.lua` file:
   ```lua
   ['police_badge'] = {
       ['name'] = 'police_badge',
       ['label'] = 'Police Badge',
       ['weight'] = 100,
       ['type'] = 'item',
       ['image'] = 'police_badge.png',
       ['unique'] = true,
       ['useable'] = true,
       ['shouldClose'] = true,
       ['combinable'] = nil,
       ['description'] = 'A police badge with your credentials.'
   },



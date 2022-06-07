#priority 1

import crafttweaker.api.tag.MCTag;
import crafttweaker.api.item.ItemStack;

// ADD TO TAGS //
<tag:items:minecraft:sand>.add(<item:rankine:desert_sand>);



// REMOVE RECIPES //
craftingTable.removeByRegex("minecraft:.*_concrete_powder");

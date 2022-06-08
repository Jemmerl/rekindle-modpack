#priority 1

import crafttweaker.api.tag.MCTag;
import crafttweaker.api.item.ItemStack;

// ADD TO TAGS //
<tag:blocks:forge:sand>.add(<block:rankine:desert_sand>);
<tag:blocks:forge:sand>.add(<block:rankine:white_sand>);




// REMOVE RECIPES //
craftingTable.removeByRegex("minecraft:.*_concrete_powder");

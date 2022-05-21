#priority 2

import mods.jei.JEI;

import crafttweaker.api.tag.MCTag;
import crafttweaker.api.item.ItemStack;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.item.MCItemDefinition;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.blocks.MCBlock;
import crafttweaker.api.item.MCItemStackMutable;
import crafttweaker.api.entity.MCItemEntity;

import crafttweaker.api.GenericRecipesManager;
import crafttweaker.api.registries.ICookingRecipeManager;
import crafttweaker.api.CampFireManager;
import crafttweaker.api.FurnaceManager;

import crafttweaker.api.loot.modifiers.CommonLootModifiers;
import crafttweaker.api.loot.LootManager;
import crafttweaker.api.loot.conditions.vanilla.BlockStateProperty;
import crafttweaker.api.loot.conditions.vanilla.MatchTool;
import crafttweaker.api.loot.LootContext;
import crafttweaker.api.loot.conditions.LootConditionBuilder;
import crafttweaker.api.loot.conditions.crafttweaker.Not;
import crafttweaker.api.loot.conditions.ILootConditionTypeBuilder;
import crafttweaker.api.loot.modifiers.ILootModifier;
import crafttweaker.api.loot.conditions.crafttweaker.ToolType;

import crafttweaker.api.event.block.MCBlockEvent;
import crafttweaker.api.event.block.MCBlockPlaceEvent;
import crafttweaker.api.event.entity.player.MCPlayerEvent;
import crafttweaker.api.event.entity.MCLivingEvent;
import crafttweaker.api.event.entity.MCEntityEvent;
import crafttweaker.api.event.entity.player.interact.MCRightClickBlockEvent;
import crafttweaker.api.event.entity.player.interact.MCRightClickItemEvent;
import crafttweaker.api.event.block.MCBlockBreakEvent;
import crafttweaker.api.event.entity.player.interact.MCPlayerInteractEvent;
import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.events.EventPriority;
import crafttweaker.api.event.entity.MCEntityJoinWorldEvent;
import crafttweaker.api.event.entity.MCItemEvent;
import crafttweaker.api.commands.custom.MCCommand;
import crafttweaker.api.commands.custom.MCCommandContext;

import crafttweaker.api.tileentity.MCTileEntity;
import crafttweaker.api.util.MCResourceLocation;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.data.INumberData;
import crafttweaker.api.data.MapData;
import crafttweaker.api.data.IData;
import crafttweaker.api.util.BlockPos;
import crafttweaker.api.util.MCHand;
import crafttweaker.api.util.text.MCTextComponent;
import crafttweaker.api.text.TextFormatting;
import crafttweaker.api.util.text.MCStyle;
import crafttweaker.api.world.MCWorld;
import crafttweaker.api.world.MCServerWorld;
import crafttweaker.api.server.MCServer;
import crafttweaker.api.util.Random;
import stdlib.List;


import crafttweaker.api.FurnaceManager;

// CONFIG CONSTANTS


// Remove vanilla campfire recipe
craftingTable.removeByName("minecraft:campfire");


//////////////////////////////////////////////////////////////////////////////
// Campfire recipes for lime mortar
campfire.addRecipe("campfire_stick_ash", <item:rekindleprimitive:fire_ash>, <item:minecraft:stick>, 0.0, 100);
campfire.addRecipe("campfire_shells_quicklime", <item:rekindleprimitive:impure_calcium_oxide>, <item:projectvibrantjourneys:seashells>, 0.0, 200);
campfire.addRecipe("campfire_bones_quicklime", <item:rekindleprimitive:impure_calcium_oxide>, <item:natural-progression:bone_shard>, 0.0, 200);
//////////////////////////////////////////////////////////////////////////////


// Remove some recipes from Campfire Overhaul
campfire.removeByName("campfire_overhaul:torches_from_campfire");
campfire.removeByName("campfire_overhaul:charcoal_from_campfire");
campfire.removeByName("campfire_overhaul:bricks_from_campfire");


// Campfires now only drop ash
var campfireTags = <tag:blocks:minecraft:campfires>;
for block in campfireTags.elements {
	block.addLootModifier(block.registryName.path+"_ash_drop",CommonLootModifiers.clearing(CommonLootModifiers.addWithRandomAmount(<item:rekindleprimitive:fire_ash>,1,3)));
}

#priority 10

import mods.jei.JEI;

import crafttweaker.api.tag.MCTag;
import crafttweaker.api.item.ItemStack;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.item.MCItemDefinition;
import crafttweaker.api.item.IIngredient;
import crafttweaker.api.blocks.MCBlock;
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

// ############################### CONFIG CONSTANTS ###############################


// ############################### FUNCTIONS ###############################

function addKilnRecipe(name as string, itemOut as IItemStack, itemIn as IItemStack, exp as float, time as int) as void {
	<recipetype:ceramics:kiln>.addJSONRecipe("ct/ceramics_kiln/" + name, {
		"type": "ceramics:kiln",
		"ingredient": {
		"item": itemIn.registryName
		},
		"result": itemOut.registryName,
		"experience": exp,
		"cookingtime": time
	});
}


// ############################### TAGS ###############################

// Geolosys mineral sample tag
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:lignite_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:bituminous_coal_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:anthracite_coal_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:coal_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:sphalerite_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:cinnabar_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:gold_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:lapis_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:quartz_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:kimberlite_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:beryl_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:nether_gold_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:ancient_debris_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:hematite_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:limonite_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:malachite_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:azurite_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:cassiterite_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:teallite_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:galena_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:bauxite_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:platinum_ore_sample>);
<tag:blocks:crafttweaker:mineral_samples>.add(<block:geolosys:autunite_ore_sample>);

// Grass-dropping plants tag
<tag:blocks:crafttweaker:grass_plants>.add(<block:projectvibrantjourneys:beach_grass>);
<tag:blocks:crafttweaker:grass_plants>.add(<block:minecraft:grass>);
<tag:blocks:crafttweaker:grass_plants>.add(<block:projectvibrantjourneys:desert_sage>);
<tag:blocks:crafttweaker:grass_plants>.add(<block:projectvibrantjourneys:prairie_grass>);
<tag:blocks:crafttweaker:grass_plants>.add(<block:projectvibrantjourneys:dry_grass>);
<tag:blocks:crafttweaker:grass_plants>.add(<block:projectvibrantjourneys:short_grass>);
<tag:blocks:crafttweaker:grass_plants>.add(<block:minecraft:tall_grass>);
<tag:blocks:crafttweaker:grass_plants>.add(<block:minecraft:fern>);
<tag:blocks:crafttweaker:grass_plants>.add(<block:minecraft:large_fern>);
<tag:blocks:crafttweaker:grass_plants>.add(<block:projectvibrantjourneys:sea_oats>);

// Remove certain items from tags
<tag:items:natural-progression:saw>.remove(<item:natural-progression:basic_saw>);


// ############################### REMOVE RECIPES ###############################

// Remove furnace crafting recipes
craftingTable.removeByName("minecraft:furnace");
craftingTable.removeByName("minecraft:blast_furnace");
craftingTable.removeByName("minecraft:smoker");

// Remove thatch wheat conversion recipes
craftingTable.removeByName("quark:building/crafting/thatch_revert");
craftingTable.removeByName("quark:building/crafting/thatch");

// Remove flint (basic) saw recipe, hide from JEI, and remove as a recipe ingredient
craftingTable.removeByName("natural-progression:crafting/saws/basic_saw");
JEI.hideItem(<item:natural-progression:basic_saw>);
craftingTable.removeRecipeByInput(<item:natural-progression:basic_saw>);

// Remove pebble to cobble recipes
for pebble in <tag:items:forge:pebbles>.elements {
	craftingTable.removeRecipeByInput(pebble);
}

// Change immersive engineering torch recipe to realistic torches
craftingTable.removeByName("immersiveengineering:crafting/torch");
	
// Remove framed torch recipes, hide from JEI, and remove as a recipe ingredient
craftingTable.removeByName("framedblocks:framed_torch");
craftingTable.removeByName("framedblocks:framed_soul_torch");
JEI.hideItem(<item:framedblocks:framed_torch>);
JEI.hideItem(<item:framedblocks:framed_soul_torch>);

// Remove vanilla torch recipe
craftingTable.removeByName("minecraft:torch");

// Remove wooden tools recipes, hide from JEI
craftingTable.removeRecipe(<item:minecraft:wooden_sword>);
craftingTable.removeRecipe(<item:minecraft:wooden_shovel>);
craftingTable.removeRecipe(<item:minecraft:wooden_pickaxe>);
craftingTable.removeRecipe(<item:minecraft:wooden_axe>);
craftingTable.removeRecipe(<item:minecraft:wooden_hoe>);
JEI.hideItem(<item:minecraft:wooden_sword>);
JEI.hideItem(<item:minecraft:wooden_shovel>);
JEI.hideItem(<item:minecraft:wooden_pickaxe>);
JEI.hideItem(<item:minecraft:wooden_axe>);
JEI.hideItem(<item:minecraft:wooden_hoe>);

// Remove stone tools recipes, hide from JEI
craftingTable.removeRecipe(<item:minecraft:stone_sword>);
craftingTable.removeRecipe(<item:minecraft:stone_shovel>);
craftingTable.removeRecipe(<item:minecraft:stone_pickaxe>);
craftingTable.removeRecipe(<item:minecraft:stone_axe>);
craftingTable.removeRecipe(<item:minecraft:stone_hoe>);
craftingTable.removeRecipe(<item:cb_microblock:stone_saw>);
JEI.hideItem(<item:minecraft:stone_sword>);
JEI.hideItem(<item:minecraft:stone_shovel>);
JEI.hideItem(<item:minecraft:stone_pickaxe>);
JEI.hideItem(<item:minecraft:stone_axe>);
JEI.hideItem(<item:minecraft:stone_hoe>);
JEI.hideItem(<item:cb_microblock:stone_saw>);

// Remove nether/certus quartz tools, hide from JEI
craftingTable.removeByName("appliedenergistics2:tools/certus_quartz_sword");
craftingTable.removeByName("appliedenergistics2:tools/certus_quartz_spade");
craftingTable.removeByName("appliedenergistics2:tools/certus_quartz_pickaxe");
craftingTable.removeByName("appliedenergistics2:tools/certus_quartz_axe");
craftingTable.removeByName("appliedenergistics2:tools/certus_quartz_hoe");
craftingTable.removeByName("appliedenergistics2:tools/nether_quartz_sword");
craftingTable.removeByName("appliedenergistics2:tools/nether_quartz_spade");
craftingTable.removeByName("appliedenergistics2:tools/nether_quartz_pickaxe");
craftingTable.removeByName("appliedenergistics2:tools/nether_quartz_axe");
craftingTable.removeByName("appliedenergistics2:tools/nether_quartz_hoe");
JEI.hideItem(<item:appliedenergistics2:certus_quartz_sword>);
JEI.hideItem(<item:appliedenergistics2:certus_quartz_shovel>);
JEI.hideItem(<item:appliedenergistics2:certus_quartz_pickaxe>);
JEI.hideItem(<item:appliedenergistics2:certus_quartz_axe>);
JEI.hideItem(<item:appliedenergistics2:certus_quartz_hoe>);
JEI.hideItem(<item:appliedenergistics2:nether_quartz_sword>);
JEI.hideItem(<item:appliedenergistics2:nether_quartz_shovel>);
JEI.hideItem(<item:appliedenergistics2:nether_quartz_pickaxe>);
JEI.hideItem(<item:appliedenergistics2:nether_quartz_axe>);
JEI.hideItem(<item:appliedenergistics2:nether_quartz_hoe>);

// Remove natural progression bone pick recipe
craftingTable.removeByName("natural-progression:crafting/bone_pickaxe");

// Remove brick smelting recipes and add customs
furnace.removeByName("minecraft:brick");
<recipetype:ceramics:kiln>.removeByName("ceramics:brick_kiln");
addKilnRecipe("brick", <item:minecraft:brick>, <item:rekindlemod:dry_unfired_brick>, 0.1, 400);

// Remove brick block recipes
craftingTable.removeByName("minecraft:bricks");
craftingTable.removeByName("ceramics:bricks_from_slab");
craftingTable.removeByName("ceramics:brick_stairs_from_bricks");
craftingTable.removeByName("ceramics:brick_slab_from_bricks");
<recipetype:thermal:press>.removeRecipe(<item:minecraft:bricks>);

// Remove ceramics kiln recipe
craftingTable.removeByName("ceramics:kiln");

// Remove default ceramic clay plate recipe and smelting recipes
craftingTable.removeByName("ceramics:unfired_clay_plate");
furnace.removeByName("ceramics:clay_plate_smelting");
<recipetype:thermal:furnace>.removeRecipe(<item:ceramics:clay_plate>);

// Remove seashells to prismarine
craftingTable.removeByName("projectvibrantjourneys:seashells");

// Remove vanilla stick recipe
craftingTable.removeByName("minecraft:stick");

// Remove vanilla bread recipes
// craftingTable.removeByName("minecraft:bread");


// ############################### TWEAKS ###############################

// Change tool durabilities
<item:natural-progression:bone_pickaxe>.maxDamage = 24;
<item:natural-progression:bone_knife>.maxDamage = 64;
<item:natural-progression:flint_hatchet>.maxDamage = 32;


// Change armor durabilites
<item:minecraft:leather_helmet>.maxDamage = 75;
<item:minecraft:leather_chestplate>.maxDamage = 100;
<item:minecraft:leather_leggings>.maxDamage = 95;
<item:minecraft:leather_boots>.maxDamage = 85;
<item:ceramics:clay_helmet>.maxDamage = 32;
<item:ceramics:clay_chestplate>.maxDamage = 32;
<item:ceramics:clay_leggings>.maxDamage = 32;
<item:ceramics:clay_boots>.maxDamage = 32;


// Change armor defense


// Certain plants now drop straw
// Rewrite to use new tooltype, knive, at a later time
var grassPlantTags = <tag:blocks:crafttweaker:grass_plants>;
for block in grassPlantTags.elements {
    loot.modifiers.register(
        block.registryName.path+"_knifedrop", 
        LootConditionBuilder.create()
			.add<MatchTool>(matches => {matches.matching(<item:natural-progression:bone_knife>);})
            .add<BlockStateProperty>(bsp => {bsp.withBlock(block);}),
        CommonLootModifiers.clearing(CommonLootModifiers.add(<item:rekindlemod:straw_grass>))
    );
}


// Knife tools take damage when breaking grass 50% of the time
CTEventManager.register<MCBlockBreakEvent>((event) => {
    val player = event.getPlayer();
    val world = player.world;
	val item as IItemStack = player.getCurrentItem();
	val damage as int = item.damage;
	val block = event.getBlockState();
    if (world.remote || (item.definition as IItemStack != <item:natural-progression:bone_knife>) || !(block in <tag:blocks:crafttweaker:grass_plants>)) {
        return;
    }
	else {
		if (world.gameTime as int % 2) {
		item.mutable().withDamage(damage + 1);
			if (item.damage >= item.maxDamage)  {
				item.mutable().shrink(1);
			}
		}
	}
});


// Mineral samples drop conditions edited
var geoSamplesTags = <tag:blocks:crafttweaker:mineral_samples>;
print("test");
for block in geoSamplesTags.elements {
    loot.modifiers.register(
        block.registryName.path+"_normdrop", 
        LootConditionBuilder.create()
            .add<Not>(not => {
                not.withCondition<ToolType>(tt => {
                    tt.withToolType(<tooltype:pickaxe>);
                });
            })
            .add<BlockStateProperty>(bsp => {
                bsp.withBlock(block);
            }),
        CommonLootModifiers.clearing(CommonLootModifiers.add(block.asItem()))
    );
}

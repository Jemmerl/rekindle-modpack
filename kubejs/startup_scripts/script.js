priority: 9

console.info('Hello, World! Hi, Mom!')

onEvent('item.registry', event => {
	// Register new items here
	// event.create('example_item').displayName('Example Item')
})

onEvent('block.registry', event => {
	// Register new blocks here
	// event.create('example_block').material('wood').hardness(2.5).displayName('Example Block')
})

events.listen('fluid.registry', event => {
	event.create('salt_water').textureThin(0x3991E9).displayName('Salt Water').bucketColor(0x3991E9) 
	// .textureStill('path').textureFlowing('path')
})
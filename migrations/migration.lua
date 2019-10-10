for index, force in pairs( game.forces ) do
  	local technologies = force.technologies
  	local recipes = force.recipes

  	recipes["Battle-Wagon-1"].enabled = technologies["modular-armor"].researched
  	recipes["Battle-Wagon-3"].enabled = technologies["power-armor"].researched
  	recipes["Battle-Wagon-3"].enabled = technologies["power-armor-mk2"].researched
end
Config = {}

-- Definition der Fahrstühle mit Koordinaten und Anforderungen für Jobs und Ränge
Config.Elevator = {
    -- Erster Fahrstuhl
    {
        floors = {
            {x = -1095.84, y = -850.77, z = 4.88, label = 'Etage -1'}, -- Etage -1
			{x = -1095.84, y = -850.77, z = 10.27, label = 'Etage -2'},  -- Etage -2
			{x = -1095.84, y = -850.77, z = 13.76, label = 'Etage-3'},  -- Etage -3
			{x = -1095.84, y = -850.44, z = 19.0, label = 'Erdgeschoss'},     -- Etage 0
			{x = -1095.84, y = -850.77, z = 23.03, label = 'Kantiene'},       -- Etage 1
			{x = -1095.84, y = -850.47, z = 26.82, label = 'Gym'},       -- Etage 2
			{x = -1095.84, y = -850.4, z = 30.76, label = 'Officer Büros'},         -- Etage 3
			{x = -1095.84, y = -850.32, z = 34.36, label = 'Chief Büros', job = 'police', rank = 4},       -- Etage 4
			{x = -1095.84, y = -850.37, z = 38.24, label = 'Helicopter Platz'},       -- Etage 5
        }
    },
    -- Zweiter Fahrstuhl
    {
        floors = {
            {x = -1100.0, y = -850.4, z = -10.0, label = 'Untergeschoss 3'},
            {x = -1100.0, y = -850.4, z = -7.0, label = 'Untergeschoss 2'},
            {x = -1100.0, y = -850.4, z = -4.0, label = 'Untergeschoss 1'},
            {x = -1099.97, y = -850.44, z = 19.0, label = 'Erdgeschoss'},
            {x = -1099.86, y = -850.55, z = 26.83, label = '1. Stock'},
            {x = -1099.93, y = -850.47, z = 30.76, label = '2. Stock'},
        }
    }
}

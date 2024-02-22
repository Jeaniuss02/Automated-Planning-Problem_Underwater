(define (problem DestroySubProblem)
    (:domain UnderwaterDomain)

    (:objects
        sub1 sub2 
        pilot1 pilot2
        engineer1 engineer2     
        scientist1 scientist2
        structure_kit1 structure_kit2
        energy_cable_kit1 
        command_centre
        land1 land2
        shallow_water1 shallow_water2 
        deep_water1 deep_water2 deep_water3 deep_water4
        protected_area
        construct_research_base1
        kraken_home
    )

    (:init
        (sub sub1)
        (sub sub2)
        (subEmpty sub1)
        (not(subFull sub1))
        (can-carry sub1)
        (subEmpty sub2)
        (not(subFull sub2))
        
        (pilot pilot1)
        (pilot pilot2)
        (personnel pilot1)
        (personnel pilot2)
        (scientist scientist1)
        (scientist scientist2)
        (personnel scientist1)
        (personnel scientist2)
        (engineer engineer1)
        (engineer engineer2)
        (personnel engineer1)
        (personnel engineer2)
        
        (kit structure_kit1)
        (structure_kit structure_kit1)
        (structure_kit structure_kit2)
        (kit energy_cable_kit1)
        (energy_cable_kit energy_cable_kit1)
        
        (location command_centre)
        (centre command_centre)
        (location shallow_water1)
        (location shallow_water2)
        (location deep_water1)
        (location deep_water2)
        (location deep_water3)
        (location deep_water4)
        (location land1)
        (location land2)
        (location construct_research_base1)
        (construct_research_base construct_research_base1)

        (land land1)
        (land land2)
        (location protected_area)
        (water deep_water1)
        (water deep_water2)
        (water deep_water3)
        (water deep_water4)
        (water protected_area)
        (deep_water deep_water1)
        (deep_water deep_water2)
        (deep_water deep_water3)
        (deep_water deep_water4)
        (subsea_scan deep_water1)
        (not(subsea_scan deep_water2))
        (not(subsea_scan deep_water4))
        (not(subsea_scan shallow_water1))
        (subsea_scan shallow_water2)
        (protected_area shallow_water1)
        (not(protected_area shallow_water2))
        (not(protected_area deep_water1))
        (not(protected_area deep_water4))
        (water shallow_water1)
        (water shallow_water2)
        (shallow_water shallow_water1)
        (shallow_water shallow_water2)
        (water protected_area)
        (water command_centre)
        (kraken_home deep_water4)
        
        (at sub1 command_centre)
        (at sub2 command_centre)
        (at pilot1 command_centre)
        (at pilot2 command_centre)
        (at engineer1 command_centre)
        (at engineer2 command_centre)
        (at structure_kit1 command_centre)
        (at energy_cable_kit1 command_centre)
        (at scientist1 command_centre)
        (at scientist2 command_centre)
      
    
        (adjacent command_centre land1)
        (adjacent land1 command_centre)
        (adjacent land1 deep_water2)
        (adjacent deep_water2 land1)
        (adjacent shallow_water1 command_centre)
        (adjacent command_centre shallow_water1)
        (adjacent command_centre shallow_water2)
        (adjacent shallow_water2 command_centre)
        (adjacent command_centre deep_water1)
        (adjacent deep_water1 command_centre)
        (adjacent land2 shallow_water2)
        (adjacent shallow_water2 land2)
        (adjacent deep_water3 shallow_water1)
        (adjacent shallow_water1 deep_water3)
        (adjacent deep_water3 shallow_water2)
        (adjacent shallow_water2 deep_water3)
        (adjacent deep_water4 deep_water3)
        (adjacent deep_water3 deep_water4)
        (adjacent deep_water4 land2)
        (adjacent land2 deep_water4)
    )

    (:goal
        (and
           (destroyed sub2)
        )
    )
)

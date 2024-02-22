(define (domain UnderwaterDomain)
    (:requirements
        :strips
    )

    (:predicates
        (personnel ?p)
        (pilot ?p)
        (engineer ?p)
        (scientist ?p)
        (sub ?s)
        (location ?l)
        (centre ?l)
        (water ?l)
        (land ?l)
        (deep_water ?l)
        (shallow_water ?l)
        (protected_area ?l)
        (kraken_home ?l)
        (kit ?k)
        (structure_kit ?k)
        (energy_cable_kit ?k)
        (subEmpty ?s)
        (subFull ?s)
        (can-carry ?s)
        (subsea_scan ?l)
        (research_scan ?l)
        (analyzed_data ?s)
        (construct_TPG ?l)
        (install_energy_cable ?l)
        (construct_research_base ?l)
        (transferred_scan_data ?l)
        (shield_on ?s)
        (shield_off ?s)
        (destroyed ?s)
        (special_sonar_array_on ?s)
        
        
        (carrying ?s ?k)
        (at  ?x ?l)
        (onboard  ?p ?s)
        (load ?k ?s)
        (adjacent ?x ?y)
    )

    (:action load
        :parameters 
            (?p ?s ?l ?k)
        :precondition
            (and
                (kit ?k)
                (sub ?s)
                (engineer ?p)
                (centre ?l)
		        (at ?s ?l)
                (at ?k ?l)
                (at ?p ?l)
                (can-carry ?s)
                (not(carrying ?s ?k))
            )
        :effect
            (and
                (load ?k ?s)
                (not (at ?k ?l))
                (not(can-carry ?s))
                (carrying ?s ?k)
            )
    )

    (:action unload
        :parameters
            (?p ?s ?l ?k)
        :precondition
            (and
                (kit ?k)
                (sub ?s)
                (engineer ?p)
                (centre ?l)
		        (at ?s ?l)
		        (at ?p ?l)
                (load ?k ?s)
                (carrying ?s ?k)
            )
        :effect
            (and
                (at ?k ?l)
                (not (load ?k ?s))
                (not (carrying ?s ?k))
                (can-carry ?s)
            )
    )

    (:action move
        :parameters
            (?s ?l1 ?l2 ?p)
        :precondition
            (and
                (sub ?s)
                (water ?l1)
                (water ?l2)
                (pilot ?p)
		        (at ?s ?l1)
		        (onboard ?p ?s)
		        (adjacent ?l1 ?l2)
            )
        :effect
            (and
                (at ?s ?l2)
                (not (at ?s ?l1))
            )
    )

    (:action onboard
        :parameters
            (?p ?s ?l)
        :precondition
            (and
                (personnel ?p)
                (sub ?s)
                (at ?s ?l)
		        (at ?p ?l)
		        (not(subFull ?s))
            )
        :effect
            (and 
                (onboard ?p ?s)
                (not (at ?p ?l))
                (not (subEmpty ?s))
                (when (and(not(subEmpty ?s)))
                    (subFull ?s))
                (when (and(subEmpty ?s))
                    (not(subFull ?s)))
            )
    )
    
    (:action unboard
        :parameters
            (?p ?s ?l)
        :precondition
            (and
                (personnel ?p)
                (sub ?s)
                (at ?s ?l)
		        (not(subEmpty ?s))
            )
        :effect
            (and 
                (not(onboard ?p ?s))
                (at ?p ?l)
                (not (subFull ?s))
                (when (and(not(subEmpty ?s)))
                    (subEmpty ?s))
                (when (and(subFull ?s))
                    (not(subEmpty ?s)))
            )
    )
    
    (:action subsea_survey_scan
        :parameters
            (?p ?s ?l)
        :precondition
            (and
                (scientist ?p)
                (sub ?s)
                (water ?l)
                (at ?s ?l)
		        (onboard ?p ?s)
		        (not(subsea_scan ?l))
            )
        :effect
            (and 
                (subsea_scan ?l)
            )
    )
    
    (:action intensive_research_scan
        :parameters
            (?p ?s ?l)
        :precondition
            (and
                (scientist ?p)
                (sub ?s)
                (water ?l)
                (at ?s ?l)
		        (onboard ?p ?s)
            )
        :effect
            (and 
                (research_scan ?l)
                (analyzed_data ?s)
            )
    )
    
     (:action tidal_power_generator_construction
        :parameters
            (?p ?s ?l1 ?l2 ?k)
        :precondition
            (and
                (engineer ?p)
                (sub ?s)
                (shallow_water ?l1)
                (not(protected_area ?l1))
                (land ?l2)
                (structure_kit ?k)
                (at ?s ?l1)
                (carrying ?s ?k)
		        (onboard ?p ?s)
		        (subsea_scan ?l1)
		        (adjacent ?l1 ?l2)
            )
        :effect
            (and 
                (construct_TPG ?l1)
                (not(carrying ?s ?k))
                (can-carry ?s)
                
            )
    )
    
    (:action offshore_energy_cable_installation
        :parameters
            (?p ?s ?l1 ?l2 ?k)
        :precondition
            (and
                (engineer ?p)
                (sub ?s)
                (water ?l1)
                (location ?l2)
                (energy_cable_kit ?k)
                (at ?s ?l1)
                (carrying ?s ?k)
		        (onboard ?p ?s)
		        (subsea_scan ?l1)
                (not(protected_area ?l1))
		        (adjacent ?l1 ?l2)
            )
        :effect
            (and 
                (install_energy_cable ?l1)
            )
    )
    
    (:action underwater_research_base_construction
        :parameters
            (?p1 ?p2 ?s1 ?s2 ?l1 ?k1 ?k2)
        :precondition
            (and
                (engineer ?p1)
                (engineer ?p2)
                (sub ?s1)
                (sub ?s2)
                (deep_water ?l1)
                (install_energy_cable ?l1)
                (structure_kit ?k1)
                (structure_kit ?k2)
                (at ?s1 ?l1)
                (at ?s2 ?l1)
                (carrying ?s1 ?k1)
                (carrying ?s2 ?k2)
		        (onboard ?p1 ?s1)
		        (onboard ?p2 ?s2)
		        (subsea_scan ?l1)
            )
        :effect
            (and 
                (construct_research_base ?l1)
                (not(carrying ?s1 ?k1))
                (can-carry ?s1)
                (not(carrying ?s2 ?k2))
                (can-carry ?s2)
            )
    )
    
    (:action onboard_sub_researchbase
        :parameters
            (?p ?s ?l)
        :precondition
            (and
                (personnel ?p)
                (sub ?s)
                (location ?l)
                (construct_research_base ?l)
                (at ?s ?l)
                (at ?p ?l)
                (not(subFull ?s))
            )
        :effect
            (and 
                (onboard ?p ?s)
                (not (at ?p ?l))
                (not (subEmpty ?s))
                (when (and(not(subEmpty ?s)))
                    (subFull ?s))
                (when (and(subEmpty ?s))
                    (not(subFull ?s)))
            )
    )
    
    (:action unboard_sub_researchbase
        :parameters
            (?p ?s ?l)
        :precondition
            (and
                (personnel ?p)
                (sub ?s)
                (location ?l)
                (construct_research_base ?l)
                (at ?s ?l)
                (not(at ?p ?l))
            )
        :effect
            (and 
                (at ?p ?l)
                (not (onboard ?p ?s))
                (when (and(not(subEmpty ?s)))
                    (subEmpty ?s))
                (when (and(subFull ?s))
                    (not(subEmpty ?s)))
                
            )
    )
    
    (:action transferred_scan
        :parameters
            (?s ?l)
        :precondition
            (and 
                (sub ?s)
                (location ?l)
                (construct_research_base ?l)
                (at ?s ?l)
                (analyzed_data ?s)
            )
        :effect
            (and
                (transferred_scan_data ?l)
            )
    )
    
    (:action turn_on_protective_shield
        :parameters
            (?p ?s)
        :precondition
            (and 
                (sub ?s)
                (pilot ?p)
                (onboard ?p ?s)
            )
        :effect
            (and
                (shield_on ?s)
            )
    )
    
    (:action turn_off_protective_shield
        :parameters
            (?p ?s)
        :precondition
            (and 
                (sub ?s)
                (pilot ?p)
                (onboard ?p ?s)
                (shield_on ?s)
            )
        :effect
            (and
                (shield_off ?s)
            )
    )
    
    (:action sub_destroyed
        :parameters
            (?s ?l)
        :precondition
            (and 
                (sub ?s)
                (kraken_home ?l)
                (at ?s ?l)
                (not(shield_on ?s))
            )
        :effect
            (and
                (destroyed ?s)
                (not(at ?s ?l))
            )
    )
    
    (:action turn_on_special_sonar_array
        :parameters
            (?p ?s ?l ?l1 ?l2)
        :precondition
            (and 
                (sub ?s)
                (water ?l)
                (engineer ?p)
                (construct_research_base ?l1)
                (construct_research_base ?l2)
                (at ?s ?l)
                (or
                    (at ?p ?l1)
                    (at ?p ?l2)
                )
            )
        :effect
            (and
                (special_sonar_array_on ?s)
                (at ?s ?l)
            )
    )
 
    
)
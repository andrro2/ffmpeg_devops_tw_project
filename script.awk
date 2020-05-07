
function in_array(value, array) {
    is_in_array = 0
    for (i in array) {
        if (array[i] == value) {
            is_in_array = 1
        }
    }
    return is_in_array
}

function write_shell_script(array) {
    print "CHANGED_DEP=$1\ncase $CHANGED_DEP in" >> output
    split("", artifact_steps)

    # GET ARTIFACT STEPS

    for (artifact in array) {
        if (artifact == "artifact") {
            for (step_index in array[artifact]["steps"]) {
                artifact_steps[length(artifact_steps)] = array[artifact]["steps"][step_index]
            }
        }
    }

    # GET FURTHER DEPENDENCIES AND STEPS

    for (artifact in array) {
        if (artifact != "artifact") {
            print "\t" artifact ")" >> output
            for (step_index in array[artifact]["steps"]) {
                print "\t\t"array[artifact]["steps"][step_index] >> output
            }
            for (as in artifact_steps) {
                print "\t\t" artifact_steps[as] >> output
            }
            print "\t\t;;" >> output
        }
    }

    split("", dependency_steps)
    for(artifact in array) {
        if (artifact != "artifact") {
            for(dep_index in array[artifact]["deps"]) {
                print "\t" array[artifact]["deps"][dep_index] ")" >> output
                for (step_index in array[artifact]["steps"]) {
                    the_real_step = array[artifact]["steps"][step_index]
                    print "\t\t" the_real_step >> output

                    if (in_array(the_real_step, dependency_steps) == 0) {
                        dependency_steps[length(dependency_steps)] = the_real_step
                    }
                }
                for (as in artifact_steps) {
                    print "\t\t" artifact_steps[as] >> output
                }
                print "\t\t;;" >> output
            }
        }
    }

    print "\t*)" >> output

    for (ds in dependency_steps) {
        print "\t\t" dependency_steps[ds] >> output
    }
    for (as in artifact_steps) {
        print "\t\t" artifact_steps[as] >> output
    }

    print "\t\t;;\nesac\n" >> output

}

BEGIN {
    RS = "\n\n";
    FS = "\t";
    output = "script.sh"
    print "#!/bin/bash\n" > output
    dependencies = 0
}

{
    target = ""
    sub(":", "", $1)
    sub("\n", "", $1)
    target = $1
}

{
    sub("\\ )", "", $3)
    sub("\\( ", "", $3)
    sub("\n", "", $3)
    split($3, dep, ", ")
    for (i in dep) {
        hierarchy[target]["deps"][i] = dep[i]
        dependencies++
    }
    sub("\\ )", "", $5)
    sub("\\( ", "", $5)
    sub("\n", "", $5)
    split($5, step, ", ")
    for (j in step) {
        hierarchy[target]["steps"][j] = step[j]
    }
}

END {
    for(artifact in hierarchy) {
        for(dependency in hierarchy[artifact]["steps"]) {
            print hierarchy[artifact]["steps"][dependency]
        }
        for(dependency in hierarchy[artifact]["deps"]) {
            print hierarchy[artifact]["deps"][dependency]
        }
    }

    print "ENNYI VAN: " dependencies

    write_shell_script(hierarchy)

    print "inotifywait sources/ -e close_write | \n" \
    "while read path action file; do \n"\
    "    ARG=$file \n"\
    "done \n" \
    "./script.sh $ARG" >> output
}


function write_shell_script(array) {
    print "CHANGED_DEP=$1\ncase $CHANGED_DEP in" >> output

    for (artifact in array) {
        print "\t" artifact ")" >> output
        for (step_index in array[artifact]["steps"]) {
            print "\t\t"array[artifact]["steps"][step_index] >> output
        }
        print "\t\t;;" >> output
    }

    for(artifact in array) {
        if (artifact != "artifact") {
            for(dep_index in array[artifact]["deps"]) {
                print "\t" array[artifact]["deps"][dep_index] ")" >> output
                for (step_index in array[artifact]["steps"]) {
                    print "\t\t"array[artifact]["steps"][step_index] >> output
                }
                print "\t\t;;" >> output
            }
        }
    }


    print "\t*)" >> output

    split("", checked_deps)

    i = 0
    searched_element = ""
    while (i < dependencies) {
        for (artifact in array) {
            for (dependency_index in array[artifact]["deps"]) {
                if (!(array[artifact]["deps"][dependency_index] in checked_deps) || searched_element == "") {
                    searched_element = array[artifact]["deps"][dependency_index]
                    print "searched_element: " searched_element
                    print "amúgym eg itt tartunk: " array[artifact]["deps"][dependency_index]
                }

                if (searched_element in array) {

                }
                else if (!(searched_element in checked_deps)) {
                    print "töltődik a checked"
                    checked_deps[length(checked_deps)] = searched_element
                    print i
                    i++
                }
            }
        }

        print "\nEZ VAN A CHECKED DEPSBEN:\n"
        for (checked in checked_deps) {
            print checked_deps[checked]
        }
    }

    print "\t\t;;\nesac" >> output
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

}

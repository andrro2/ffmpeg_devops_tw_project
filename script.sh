#!/bin/bash

CHANGED_DEP=$1
case $CHANGED_DEP in
	intro)
		echo "build intro -dep dependency4 -dep dependency5"
		echo "build artifact -dep intro -dep content -dep outro"
		echo "artifact step2"
		;;
	content)
		echo "build intro -dep dependency6 -dep dependency7"
		echo "build artifact -dep intro -dep content -dep outro"
		echo "artifact step2"
		;;
	outro)
		echo "build intro -dep dependency8 -dep dependency9"
		echo "build artifact -dep intro -dep content -dep outro"
		echo "artifact step2"
		;;
	dependency4)
		echo "build intro -dep dependency4 -dep dependency5"
		echo "build artifact -dep intro -dep content -dep outro"
		echo "artifact step2"
		;;
	dependency5)
		echo "build intro -dep dependency4 -dep dependency5"
		echo "build artifact -dep intro -dep content -dep outro"
		echo "artifact step2"
		;;
	dependency6)
		echo "build intro -dep dependency6 -dep dependency7"
		echo "build artifact -dep intro -dep content -dep outro"
		echo "artifact step2"
		;;
	dependency7)
		echo "build intro -dep dependency6 -dep dependency7"
		echo "build artifact -dep intro -dep content -dep outro"
		echo "artifact step2"
		;;
	dependency8)
		echo "build intro -dep dependency8 -dep dependency9"
		echo "build artifact -dep intro -dep content -dep outro"
		echo "artifact step2"
		;;
	dependency9)
		echo "build intro -dep dependency8 -dep dependency9"
		echo "build artifact -dep intro -dep content -dep outro"
		echo "artifact step2"
		;;
	*)
		echo "build intro -dep dependency4 -dep dependency5"
		echo "build intro -dep dependency6 -dep dependency7"
		echo "build intro -dep dependency8 -dep dependency9"
		echo "build artifact -dep intro -dep content -dep outro"
		echo "artifact step2"
		;;
esac




STATE := 36
PLACE := 51000
PLACE_NAME := "New York, NY"



DATA_DIR := ../faradata/working

DATA := $(DATA_DIR)/faracen.csv

# Where to put the results. For this demonstration
OUTPUT_DIR := ./build

PLOT_DIR := $(OUTPUT_DIR)/impact/$(STATE)/$(PLACE)

X_FEATURES=\
    B03002_001E \
	MedianFamilyIncome \
	frac_B03002_003E frac_B03002_004E frac_B03002_005E frac_B03002_006E \
	frac_B03002_007E frac_B03002_008E frac_B03002_010E frac_B03002_011E \
	frac_B03002_012E

# We are trying to predict low access.
Y_FEATURE=lapophalfshare
Y_NAME := "Low Access Share at 1/2 Mile"

# Weight is total population.
W_FEATURE=B03002_001E

# CBSA
#CBSA := 35620
#CBSA := 12060
#CBSA := 16980

# Feature Names
FEATURE_NAME_B03002_001E="Population"
FEATURE_NAME_MedianFamilyIncome="Median Family Income"
FEATURE_NAME_frac_B03002_003E="Fraction of Population Who Identify as Non-Hipanic or Latino White Alone"
FEATURE_NAME_frac_B03002_004E="Fraction of Population Who Identify as Non-Hipanic or Latino Black of African American Alone"
FEATURE_NAME_frac_B03002_005E="Fraction of Population Who Identify as Non-Hipanic or Latino American Indian and Alaska Native Alone"
FEATURE_NAME_frac_B03002_006E="Fraction of Population Who Identify as Non-Hipanic or Latino Asian Alone"
FEATURE_NAME_frac_B03002_007E="Fraction of Population Who Identify as Non-Hipanic or Latino Native Hawaiian and Other Pacific Islander Alone"
FEATURE_NAME_frac_B03002_008E="Fraction of Population Who Identify as Non-Hipanic or Latino Some Other Race Alone"
FEATURE_NAME_frac_B03002_010E="Fraction of Population Who Identify as Non-Hipanic or Latino Two Races Including Some Other Race"
FEATURE_NAME_frac_B03002_011E="Fraction of Population Who Identify as Non-Hipanic or Latino Two Races Excluding Some Other Race, and Three or More Races"
FEATURE_NAME_frac_B03002_012E="Fraction of Population Who Identify as Hispanic or Latino of Any Race"

FILTERS := STATE=$(STATE) PLACE=$(PLACE)
PLOT_SUBTITLE := $(PLACE_NAME)

# Plot configuration details: k = size of ensemble; seed = random number generator seed.
K := 50
SEED := 0xD48BA7E5

## ADVANCED SETTINGS
#
# In most cases there should be nothing below here that needs
# to be changed.

# Merge the names and features into a form that is easy
# for the command-line tool to parse.
NAMED_X_FEATURES := $(foreach f,$(X_FEATURES),$(f):$(FEATURE_NAME_$(f)))

# There is one plot file per feature, with a suffix for the filter
to_suffix = $(subst $(eval ) ,-,$1)
PLOTS := $(X_FEATURES:%=${PLOT_DIR}/%_$(call to_suffix,$(FILTERS)).png)

.PHONY: all params plot clean

all: plot

PARAMS = $(OUTPUT_DIR)/params-$(STATE)-$(PLACE).yaml

params: $(PARAMS)

# Optimize to get the parameters.
$(PARAMS): $(DATA_DIR)/faracen-$(STATE).csv
	mkdir -p ${@D}
	impactchart \
	--log INFO \
  	optimize \
	-X ${X_FEATURES} \
	-y ${Y_FEATURE} \
	-w ${W_FEATURE} \
	-f STATE=$(STATE) PLACE=$(PLACE) \
	-o $@ \
	$<


# All the plots are generated by a single invocation.

PLOTS := $(X_FEATURES:%=$(PLOT_DIR)/%.png)

plot: $(PLOTS)

${PLOTS} &: ${PARAMS} $(DATA_DIR)/faracen-$(STATE).csv
	echo Plotting $(PLOTS)
	mkdir -p ${PLOT_DIR}
	impactchart \
	--log INFO \
	plot \
	-p ${PARAMS} \
	-X ${NAMED_X_FEATURES} \
	-y ${Y_FEATURE} \
	-w ${W_FEATURE} \
	-f ${FILTERS} \
	--subtitle ${PLOT_SUBTITLE} \
	--y-name ${Y_NAME} \
	-o ${PLOT_DIR} \
	-S ${SEED} \
	-k ${K} \
	$(DATA_DIR)/faracen-$(STATE).csv

clean:
	-rm ${PLOT_DIR}/*
	-rm ${PARAMS}


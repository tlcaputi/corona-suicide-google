import re
from gtrendspy import topterms, timeline

ROOTPATH = "C:/Users/tcapu/Google Drive/PublicHealthStudies/coronasuicide"


timeline.theo_timeline(
    terms = ['suicide - squad'],
    names = ['suicide'],
    start = '2019-01-01',
    end = '2020-06-10',
    timeframe_list = ['day'],
    geo_country_list = ['US'],
    us_states = False,
    worldwide = False,
    timestep_years = 1,
    batch_size = 2,
    outpath = "{}/input".format(ROOTPATH),
    creds = "C:/Users/tcapu/Google Drive/modules/gtrendspy/info_mark.py"
)

rw_terms = [
            '"commit suicide"',
            '"suicide hotline"',
            '"suicide prevention"',
            '"suicide rates"',
            '"my suicide"',
            '"teen suicide"',
            '"suicide number"',
            '"suicide attempt"',
            '"suicide awareness"',
            '"suicidal"',
            '"suicide note"',
            '"suicide song"',
            '"suicide bridge"',
            '"suicide quotes"',
            '"suicide"',
            '"how to commit suicide"',
            '"how to kill yourself"',
            '"how many people commit suicide"',
            '"suicidal thoughts"',
            '"suicide news"',
            '"suicidal ideation"'
            ]

rw_names = [re.sub("[+]","", x) for x in rw_terms]
rw_names = [re.sub('\"',"", x) for x in rw_names]
rw_names = [re.sub(" ","_", x) for x in rw_names]
rw_names = [re.sub("__","_", x) for x in rw_names]

timeline.theo_timeline(
    terms = rw_terms,
    names = rw_names,
    start = '2020-01-15',
    end = '2020-06-10',
    timeframe_list = ['day'],
    geo_country_list = ['US'],
    us_states = False,
    worldwide = False,
    timestep_years = 1,
    batch_size = 3,
    outpath = "{}/input/individual".format(ROOTPATH),
    creds = "C:/Users/tcapu/Google Drive/modules/gtrendspy/info_mark.py"
)

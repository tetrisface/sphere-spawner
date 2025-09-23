return {
    name='mod test 2',
    description='Your mod description',
    version='v1.0.0',
    shortname='YOURMOD',
    mutator='0', -- or '1' if it's a mutator
    game='Beyond All Reason',
    shortGame='BAR',
    modtype=1,
    depend = {
        [[rapid://byar:stable]],
    },
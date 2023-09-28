
using {disquera as my} from '../db/schema';

service disqueraService {
    @cds.redirection.target
    entity Musicians as select from  my.Musicians{
        ID,
        first_name,
        last_name
    };

    entity Musicians_Bands as
        select from my.Musicians_Bands {
            band.name as band_name,
            band.records.name as record_name,
            band.records.amount as record_amount,
            band.records.distribution.distribution.name as distribution_name,
            musicians: redirected to Musicians
        };
    
    entity Sessions as 
        select from my.Sessions {
            *,
            createdAt as created,
            record.name as record_name,
            record.band.name as band_name,
            record.band.genre as band_genre,
            musician.first_name as musician_first_name,
            musician.last_name as musician_last_name,
        } order by created desc limit 1;

    function getMusicianByID(musicianID: UUID) returns Musicians;

    action InsertMassMusicians (musicians: array of Musicians);
    action DeleteMassMusicians (IDS: array of UUID);

}
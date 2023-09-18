using {disquera as my} from '../db/schema';

service disqueraService {
    entity Musicians_Bands as
        select from my.Musicians_Bands {
            band.name as band_name,
            band.records.name as record_name,
            band.records.amount as record_amount,
            band.records.distribution.distribution.name as distribution_name,
        };
    
    entity Sessions as 
        select from my.Sessions {
            createdAt as created,
            record.name as record_name,
            record.band.name as band_name,
            record.band.genre as band_genre,
            musician.first_name as musician_first_name,
            musician.last_name as musician_last_name,
        } excluding{
            createdBy,
            modifiedAt,
            modifiedBy
        }order by created desc limit 1;
}
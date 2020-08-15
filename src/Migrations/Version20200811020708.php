<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20200811020708 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE email_settings ADD email_account_id INT NOT NULL');
        $this->addSql('ALTER TABLE email_settings ADD CONSTRAINT FK_EE23BF8C37D8AD65 FOREIGN KEY (email_account_id) REFERENCES email_account (id)');
        $this->addSql('CREATE INDEX IDX_EE23BF8C37D8AD65 ON email_settings (email_account_id)');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('ALTER TABLE email_settings DROP FOREIGN KEY FK_EE23BF8C37D8AD65');
        $this->addSql('DROP INDEX IDX_EE23BF8C37D8AD65 ON email_settings');
        $this->addSql('ALTER TABLE email_settings DROP email_account_id');
    }
}

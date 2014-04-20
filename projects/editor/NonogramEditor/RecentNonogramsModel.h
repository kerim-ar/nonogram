#ifndef RECENTNONOGRAMSMODEL_H
#define RECENTNONOGRAMSMODEL_H

#include <QAbstractListModel>

class RecentNonogramsModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles { FilePath = Qt::UserRole + 1, FileName };

    explicit RecentNonogramsModel(QObject * parent = 0);

    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

public slots:
    void setRecentNonograms(const QStringList &recentNonograms);

private:
    QStringList m_recentNonograms;
};

#endif // RECENTNONOGRAMSMODEL_H
